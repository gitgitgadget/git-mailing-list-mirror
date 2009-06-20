From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] gitweb: gravatar support
Date: Sat, 20 Jun 2009 21:24:31 +0200
Message-ID: <200906202124.33278.jnareb@gmail.com>
References: <1245435670-5688-1-git-send-email-giuseppe.bilotta@gmail.com> <7v63esklxh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 21:21:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI67m-00013m-T1
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 21:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbZFTTT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 15:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbZFTTT1
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 15:19:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:22565 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbZFTTT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 15:19:26 -0400
Received: by fg-out-1718.google.com with SMTP id d23so289567fga.17
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PdhDqLJu3QclHrkCcb4Lf2xsbX1Uvw6lSm4h+VSqEaA=;
        b=OPSe4EDs0bPq19LqnmBbFSOJUstM2OehkwKQwsCrUwzfkCKjBlJ5VKNvH07fj7x1KZ
         HXVFp8F+6nXQb3tSXYCWExp+cL+zBh1WG9XRTv8i3/sWNhhk2lk8WeZcpHvW6NPIO8Yt
         qOQGz6V+sS3VHHQrRTl6ov9vvooch2qCEtPu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xJBGwSyjrFhgixvCuiKPFB+ZPwFRDVJtvngr5Il3BqtlX3rgPxihUdphRC0lwHrB54
         398ablFBjMVd50nD9zCwOj+5tEYe5+A6ebt8Tdx6MM77Y0bIgZmmUp++6HE7zrGciIhP
         Z8lO73Ruw/W+ClSgaR0cQR1uhR4/W/qiG/Lm8=
Received: by 10.86.33.10 with SMTP id g10mr4505052fgg.21.1245525567694;
        Sat, 20 Jun 2009 12:19:27 -0700 (PDT)
Received: from ?192.168.1.13? (abwr61.neoplus.adsl.tpnet.pl [83.8.241.61])
        by mx.google.com with ESMTPS id d6sm3251677fga.4.2009.06.20.12.19.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Jun 2009 12:19:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v63esklxh.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121951>

On Fri, 19 June 2009, Junio C Hamano wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> I see these repeated patterns in your patch.
> 
> > @@ -4145,7 +4179,7 @@ sub git_shortlog_body {
> >  		my $author = chop_and_escape_str($co{'author_name'}, 10);
> >  		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
> >  		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
> > -		      "<td><i>" . $author . "</i></td>\n" .
> > +		      "<td>" . git_get_gravatar($co{'author_email'}, 16, 1) . "<i>" . $author . "</i></td>\n" .
> >...
> > -		      "<td><i>" . $author . "</i></td>\n" .
> > +		      "<td>" . git_get_gravatar($co{'author_email'}, 16, 1) . "<i>" . $author . "</i></td>\n" .
> >...
> > -		      "<td><i>" . $author . "</i></td>\n" .
> > +		      "<td>" . git_get_gravatar($co{'author_email'}, 16, 1) . "<i>" . $author . "</i></td>\n" .
> >...
> > -	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td></tr>\n".
> > +	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td>".
> > +	      "<td rowspan=\"2\">" .git_get_gravatar($co{'author_email'}) . "</td></tr>\n" .
> >...
> > -	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td></tr>\n";
> > +	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td>".
> > +	      "<td rowspan=\"2\">" .git_get_gravatar($co{'committer_email'}) . "</td></tr>\n";
> >...
> 
> Doesn't it strike you as needing a bit more refactoring?  The first three
> are identical, and you can refactor them to
> 
> -		      "<td><i>" . $author . "</i></td>\n" .
> +		      "<td>" . oneline_person($author) . "</td>\n" .
> 
> where oneline_person is
> 
> 	sub oneline_person {
>         	my ($me) = @_;
>                 return ($me->{'smallicon'} .
> 			"<i>" . $me->{'name_escaped'} . "</i>");
>         }
[...]

Well, gitweb certainly needs some love^W refactoring.  That is only one
of areas.  But should we postpone introducing new features till gitweb
gets cleaned up?  Although in this case I guess we can do cleanup during
introduction of new feature (which makes stronger case for factorizing
common elements, as they just get larger, those common elements, now with
this feature).

> That way, people who do not like italics, or people who want to have the
> icon at the end instead of at the beginning, can touch only one place
> (i.e. "sub oneline_person").

About using presentational HTML: I think one reason behind keeping it
is to have gitweb work also in text browsers like lynx, w3m or lynx, 
which can not understand CSS.

[...]
> In the medium term, we may want to go one step further and do
> 
>     package person;
> 
> and make sets of methods like "oneline_person".

That would be first in gitweb.

BTW. Should we split gitweb into packages? Should we split gitweb into
separate files (one package per file)?
-- 
Jakub Narebski
Poland
