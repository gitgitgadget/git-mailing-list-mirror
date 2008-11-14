From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 04/11] gitweb: optional custom name for refs in git_heads_body
Date: Sat, 15 Nov 2008 00:32:14 +0100
Message-ID: <200811150032.14558.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 00:33:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L18AV-0006k3-Uq
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 00:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbYKNXcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 18:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbYKNXcZ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 18:32:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:20607 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbYKNXcY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 18:32:24 -0500
Received: by ug-out-1314.google.com with SMTP id 39so15365ugf.37
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 15:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=H0p/8Z4otGTq2HwKgM/3/9z1jI+zZSURqVROVMHm4jc=;
        b=Y+4asmat9C8DTuRuFXWDKV6p+9PllAbO293F01r6yAq0nBiLJabBvTm7eHb1jByZgo
         R4NDyvr9tqEnm2ZhcwNt6Hv/QG7bQYJuAAWuR/b29oJ8Y17X2NZ6CAQMPuSlWpRvF2Yx
         W1uFybRvBlm5FsUNdUZXS/W6jwo0kdcvEKi6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DKrJoT6rqTjyLF5pfsoDb57CvrZdZv8jhAH2QQ4HKzmq+lrmrMzw3p6w8N+q9eutxT
         S1/Er8dfjca1lrzmP1sQmD1rMjy1muuKxmx4GveIZg0wePcwGCAT4m6vW3wLftmafLWp
         Dh9YFhAqFdE7/PowaGqxXydPRezGqkQKa9z44=
Received: by 10.67.92.17 with SMTP id u17mr27219ugl.17.1226705536841;
        Fri, 14 Nov 2008 15:32:16 -0800 (PST)
Received: from ?192.168.1.11? (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id x37sm27378ugc.50.2008.11.14.15.32.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Nov 2008 15:32:15 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101034>

On Thu, 13 Nov 2008, Giuseppe Bilotta wrote:

> We make a clear separation between the hash reference and the displayed
> name for refs displayed by git_heads_body. This can be used e.g. to
> group them and display only the distinct part of the name.

It is not clear for me from this commit message what this patch
is meant to do. Already git_heads_body (and also git_tags_body)
uses $ref{'name'} for display, and $ref{'fullname'} for linking
(to avoid possibility of tag/branch name conflict).

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ab29aec..a736f2a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4288,16 +4288,18 @@ sub git_heads_body {
>  		} else {
>  			print "<tr class=\"light\">\n";
>  		}
> +		my $hname = $ref{'hname'} || $ref{'fullname'} || $ref{'name'};

I don't remember setting $ref{'hname'} anywhere; if there is a patch
that sets this, it should really be squashed together with this commit.
Otherwise the commit is not standalone, as it should be.

> +		my $name = $ref{'name'};

I understand that this is simply "shortcut" name, to avoid using
$ref{'name'} everywhere else, and instead using $name?  This is a bit
independent, I mean in the sense that it makes sense to squash those
patches together in a kind of "by the way" way, i.e. simplify the code
if we are making changes in this area.

>  		$alternate ^= 1;
>  		print "<td><i>$ref{'age'}</i></td>\n" .
>  		      ($curr ? "<td class=\"current_head\">" : "<td>") .
> -		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'fullname'}),
> -		               -class => "list name"},esc_html($ref{'name'})) .
> +		      $cgi->a({-href => href(action=>"shortlog", hash=>$hname),
> +		               -class => "list name"},esc_html($name)) .
>  		      "</td>\n" .
>  		      "<td class=\"link\">" .
> -		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'fullname'})}, "shortlog") . " | " .
> -		      $cgi->a({-href => href(action=>"log", hash=>$ref{'fullname'})}, "log") . " | " .
> -		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'fullname'}, hash_base=>$ref{'name'})}, "tree") .
> +		      $cgi->a({-href => href(action=>"shortlog", hash=>$hname)}, "shortlog") . " | " .
> +		      $cgi->a({-href => href(action=>"log", hash=>$hname)}, "log") . " | " .
> +		      $cgi->a({-href => href(action=>"tree", hash=>$hname, hash_base=>$hname)}, "tree") .
>  		      "</td>\n" .
>  		      "</tr>";
>  	}

So, in short I think this patch needs work, at least better commit
message (perhaps I don't understand something...)

-- 
Jakub Narebski
Poland
