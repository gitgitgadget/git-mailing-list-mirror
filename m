From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Thunderbird: fix appp.sh format problems
Date: Fri, 31 Aug 2012 09:50:20 -0700
Message-ID: <7v7gsfovjn.fsf@alter.siamese.dyndns.org>
References: <50406EDA.2050505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Stornelli <marco.stornelli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 18:50:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7UQS-0003ig-4D
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 18:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499Ab2HaQuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 12:50:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab2HaQuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 12:50:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9122A83B0;
	Fri, 31 Aug 2012 12:50:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TwtMyOcipBpK/tbBpMaKWgXjecM=; b=XWHprh
	J81d3OVRvOnviOjJIQC3LBYK8RCoeSsZkja/lu67QQb+BSOkNwcuHApOziqfGXIU
	4PpGpju0DD7npF1Kh//a4eZnMSeT/+DHVANhd52zjAmtP+K0E1r+CYr2mXTGX/48
	WBk9Gjsd8Zp053dkb1LiAdukO/unkogrC2Ssc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xaiBGjKCI0T279jwHq2qVu/roei8S2nO
	TCejHgtW2fJ5/gMmp8IdbuTaj20uuvpijmY7MH8f1SA86MA/NLRVFbGDKO5xQCdC
	cg1+Db+ay9emATkN8qjTQEqOJkfhXVimVL+lZV4D7csjo8xNXrkjdwvdqIMNV7wd
	XcSV33P6bvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E37483AF;
	Fri, 31 Aug 2012 12:50:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD95783AD; Fri, 31 Aug 2012
 12:50:22 -0400 (EDT)
In-Reply-To: <50406EDA.2050505@gmail.com> (Marco Stornelli's message of "Fri,
 31 Aug 2012 09:59:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F49E29D6-F38B-11E1-8762-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204592>

Marco Stornelli <marco.stornelli@gmail.com> writes:

> The current script has got the following problems:
>
> 1) It doesn't work if the language used by Thunderbird is not English;
> 2) The field To: filled by format-patch is not evaluated;
> 3) The field Cc: is loaded from Cc used in the commit message
> instead of using the Cc field filled by format-patch in the email
> header.
>
> Added comments for point 1), added parsing of To: for point 2) and
> added parsing of Cc: in the email header for point 3), removing the
> Cc: parsing from commit message.
>
> Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
> ---
>
> v3: parse only To: and Cc: in the email header, fix some comments
> v2: changed the commit message to reflect better the script implementation
> v1: first draft
>
>  contrib/thunderbird-patch-inline/appp.sh |   21 +++++++++++++++++----
>  1 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
> index 5eb4a51..9325366 100755
> --- a/contrib/thunderbird-patch-inline/appp.sh
> +++ b/contrib/thunderbird-patch-inline/appp.sh
> @@ -6,6 +6,9 @@
>  
>  # ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
>  
> +# NOTE: You must change some words in this script according to the language
> +# used by Mozilla Thunderbird, as <Subject>, <To>, <Don't remove this line>.
> +
>  CONFFILE=~/.appprc
>  
>  SEP="-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-"
> @@ -26,17 +29,27 @@ fi
>  cd - > /dev/null
>  
>  SUBJECT=`sed -n -e '/^Subject: /p' "${PATCH}"`
> -HEADERS=`sed -e '/^'"${SEP}"'$/,$d' $1`
>  BODY=`sed -e "1,/${SEP}/d" $1`
>  CMT_MSG=`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
>  DIFF=`sed -e '1,/^---$/d' "${PATCH}"`
> +MAILHEADER=`sed '/^$/q' "${PATCH}"`
> +
> +export MAILHEADER
> +CCS=`perl -e 'local $/=undef; $text=$ENV{'MAILHEADER'};
> +$cc = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $cc =~ s/\n//g;
> +print $cc;'`
>  
> -CCS=`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
> -	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
> +TO=`perl -e 'local $/=undef; $text=$ENV{'MAILHEADER'};
> +$to = $1 if $text =~ /To: (.*?(,\n .*?)*)\n/s; $to =~ s/\n//g;
> +print $to;'`
>  
> +# Change Subject: before next line according to Thunderbird language
> +# for example to translate in Italian:
> +# SUBJECT=`echo $SUBJECT | sed -e 's/Subject/Oggetto/g'`
>  echo "$SUBJECT" > $1

Yeah that is much easier to understand.

You would want to write it with 's/^Subject:/Oggetto:/', though; you
want to rewrite

	Subject: Subject appears as Oggetto in Thunderbird for Italian

to

	Oggetto: Subject appears as Oggetto in Thunderbird for Italian

without touching "Subject" that appear anywhere other than at the
beginning, suffixed with ":".

> +# Change To: according to Thunderbird language
> +echo "To: $TO" >> $1
>  echo "Cc: $CCS" >> $1
> -echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
>  echo "$SEP" >> $1
>  
>  echo "$CMT_MSG" >> $1
