From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 9/8] gitweb: put signoff lines in a table
Date: Sat, 27 Jun 2009 11:55:04 +0200
Message-ID: <200906271155.04602.jnareb@gmail.com>
References: <1245926587-25074-9-git-send-email-giuseppe.bilotta@gmail.com> <1245936097-29538-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 11:56:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKUd9-0002Ct-0Y
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 11:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbZF0JzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 05:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbZF0JzN
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 05:55:13 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:47168 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbZF0JzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 05:55:11 -0400
Received: by bwz9 with SMTP id 9so2424924bwz.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rCIoxn3YPhyMRDcOdnb6/WiP5TwMYfuve6tK2xBtmXc=;
        b=tSavY2Fjy9shlbfPBt7VXGOJTPAfs2cuOBP/WuHj2S8rtjZ9FsrcZHENuaJ12/3/BO
         gDAC8OsH1ccZ9z5NUDm30PsDBg3Ay270aRn6bymA0YnjLie/KvNck8KJCPafY8LftRYG
         DAsuyjv1ZzvwaagH8hlcoZilNHwp+idvOe6EA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CcfOF/sBUfpACt7YBBWJ8+hXq2bgjN84qi9m2CgNXYZVtXB7xSw81HZEks89Hi9zbN
         hxv5T+GmcppwVEhbbDTOg5NGiDCwy/zC62/C7uGf1EAgl+pmHjOAXEC1O4VnSjrYpnp7
         bTCQtEiyC1bGSXZeWoa4rmhwcumqiHiSAbUIM=
Received: by 10.204.103.145 with SMTP id k17mr809873bko.79.1246096513162;
        Sat, 27 Jun 2009 02:55:13 -0700 (PDT)
Received: from ?192.168.1.13? (abwd106.neoplus.adsl.tpnet.pl [83.8.227.106])
        by mx.google.com with ESMTPS id 22sm7333169fkq.53.2009.06.27.02.55.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 02:55:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245936097-29538-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122351>

On Thu, 25 June 2009, Giuseppe Bilotta wrote:

> This allows us to give better alignments to the components.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
> 
> Better, but still far from perfect.

I don't like it.  NAK from me (for this experimental patch).

First it breaks correspondence between gitweb's 'commit'/'commitdiff'
view and git-show, and between gitweb's 'log' view and git-log.
I'd rather we kept that gitweb output is similar to CLI output, so
somebody familiar with one of them would have it easy understanding
the other.  Consistency in output.

Second, I have checked how it looks like in few examples:
e1d37937 (different types of signoff) and 8dfb17e1 (empty line in 
signoff block) and I have the following complaints:
 * There is extra vertical whitespace between signoff lines
 * The ':' character terminating signoffs is lost
 * Empty line vanished (which might be considered good thing).

> 
>  gitweb/gitweb.css  |    6 +++++-
>  gitweb/gitweb.perl |   47 +++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index ad82f86..21c24fa 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -115,10 +115,14 @@ span.age {
>  	font-style: italic;
>  }
>  
> -span.signoff {
> +.signoff {
>  	color: #888888;
>  }

This change might be good to have nevertheless, for future extendability.

>  
> +table.signoff td:first-child {
> +	text-align: right;
> +}

Advanced CSS selector.  Not all web browsers support it (although 
nowadays I suppose most do support ':first-child' pseudo-class).

> +
>  div.log_link {
>  	padding: 0px 8px;
>  	font-size: 70%;
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d385f55..53b8817 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3402,15 +3402,31 @@ sub git_print_log {
>  	# print log
>  	my $signoff = 0;
>  	my $empty = 0;
> +	my $signoff_table = 0;
>  	foreach my $line (@$log) {
> -		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|(?:trivially[ \-])?acked[ \-]by[ :]|cc[ :])/i) {
> -			$signoff = 1;
> +		if ($line =~ s/^ *(signed[ \-]off[ \-]by|(?:trivially[ \-])?acked[ \-]by|cc|looks[ \-]right[ \-]to[ \-]me[ \-]by)[ :]//i) {
> +			$signoff = $1;

Extending regexp for signoff matching is _independent_ change, and IMHO
should be put in separate commit (perhaps squashed in 7/8).  We really
need to do something about it, as this regexp starts to be unwieldingly
long... but this issue is already discussed in subthread for patch 7/8
in this series.

You changed "$signoff = 1;" to "$signoff = $1;" and later catch $email...
why not do it in the same line, using single (more complicated) regexp?

Also you don't catch terminating ':' in $signoff (see complain above).

>  			$empty = 0;
>  			if (! $opts{'-remove_signoff'}) {
> -				my ($email) = $line =~ /<(\S+@\S+)>/;
> -				print "<span class=\"signoff\">" . esc_html($line) . "</span>";
> -				print git_get_avatar($email, 'pad_before' => 1) if $email;
> -				print "<br/>\n";
> +				if (!$signoff_table) {
> +					print "<table class=\"signoff\">\n";
> +					$signoff_table = 1;
> +				}
> +				my $email;
> +				if ($line =~ s/\s*<(\S+@\S+)>//) {
> +					$email = $1;
> +				}
> +				print "<tr>";
> +				print "<td>$signoff</td>";
> +				print "<td>" . esc_html($line) . "</td>";
> +				if ($email && $git_avatar) {
> +					print "<td>";
> +					print git_get_avatar($email);
> +					print "</td>";
> +				} else {
> +					print "<td>" . esc_html("<$email>") . "</td>";
> +				}
> +				print "</tr>\n";
>  				next;
>  			} else {
>  				# remove signoff lines
> @@ -3429,7 +3445,26 @@ sub git_print_log {
>  			$empty = 0;
>  		}
>  
> +		# if we're in a signoff block, empty lines
> +		# are empty rows, other lines terminate
> +		# the block
> +		if ($signoff_table) {
> +			if ($empty) {
> +				print "<tr />\n";
> +				next;
> +			}

I'd rather use "<tr></tr>\n" here instead.

> +			print "</table>\n";
> +			$signoff_table = 0;
> +		}
> +
>  		print format_log_line_html($line) . "<br/>\n";
> +
> +	}
> +
> +	# close the signoff table if it's still open
> +	if ($signoff_table) {
> +		print "</table>\n";
> +		$signoff_table = 0;
>  	}
>  
>  	if ($opts{'-final_empty_line'}) {
> -- 

Much more complicated code, not much gain IMHO.  It is not worth it
(even if you think that the layout is better; I don't think that).

-- 
Jakub Narebski
Poland
