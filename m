From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] gitweb: add the ability to show side-by-side diff on
 commitdiff.
Date: Sun, 16 Oct 2011 17:20:51 -0700
Message-ID: <7vobxgpixo.fsf@alter.siamese.dyndns.org>
References: <CAFo4x0Kb651CyxoP8wxR36aDe5=Md2UV3qjh+HPo4ad6NB=Emg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 02:21:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFawv-00053L-BH
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 02:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061Ab1JQAUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 20:20:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442Ab1JQAUy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 20:20:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 060AB6A65;
	Sun, 16 Oct 2011 20:20:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ln8i5jHuq+NHajFJtTSsYNx2/sU=; b=qkE1P4
	UqQ1OvMPt01WrVqgWwZ0Xz/WybFw3qIxQHdcnIg5k3c2SlPkiotPZs2WW3F/P6iL
	JReplXjzS17M0F/7Y2YEjOANarkSGjOxxnIFSoqxlmTfiAlrbrQd25S/dnSqQm6u
	BEU/R8bT/azo58msQQbWX75PVc65sd7fpidxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PC5JXHDo8w0dehcOV2dGbjs2hFmOH/3s
	4MmvP1CsNeRwk3V0mMd/6qdIxFse6Z2JpvL5mCiQfjF4CCuJV5EnjPXWUtwBJtnu
	pw3xlv+WpoO81FaQAq9ZNS4wRgrXa6bMx5K95w3Yikl4vUiakaFTO13H56v/c3th
	6OzRbl5bElU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F23CD6A63;
	Sun, 16 Oct 2011 20:20:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67DDB6A62; Sun, 16 Oct 2011
 20:20:53 -0400 (EDT)
In-Reply-To: <CAFo4x0Kb651CyxoP8wxR36aDe5=Md2UV3qjh+HPo4ad6NB=Emg@mail.gmail.com> (Kato
 Kazuyoshi's message of "Mon, 17 Oct 2011 08:57:31 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFF458C0-F855-11E0-B366-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183745>

Kato Kazuyoshi <kato.kazuyoshi@gmail.com> writes:

> @@ -2235,25 +2238,25 @@ sub format_diff_line {
>  		# combined diff
>  		my $prefix = substr($line, 0, scalar @{$from->{'href'}});
>  		if ($line =~ m/^\@{3}/) {
> -			$diff_class = " chunk_header";
> +			$diff_class = "chunk_header";
>  		} elsif ($line =~ m/^\\/) {
> -			$diff_class = " incomplete";
> +			$diff_class = "incomplete";
>  		} elsif ($prefix =~ tr/+/+/) {
> -			$diff_class = " add";
> +			$diff_class = "add";
>  		} elsif ($prefix =~ tr/-/-/) {
> -			$diff_class = " rem";
> +			$diff_class = "rem";
>  		}
>  	} else {
>  		# assume ordinary diff
>  		my $char = substr($line, 0, 1);
>  		if ($char eq '+') {
> -			$diff_class = " add";
> +			$diff_class = "add";
>  		} elsif ($char eq '-') {
> -			$diff_class = " rem";
> +			$diff_class = "rem";
>  		} elsif ($char eq '@') {
> -			$diff_class = " chunk_header";
> +			$diff_class = "chunk_header";
>  		} elsif ($char eq "\\") {
> -			$diff_class = " incomplete";
> +			$diff_class = "incomplete";
>  		}
>  	}
>  	$line = untabify($line);
> @@ -2274,7 +2277,7 @@ sub format_diff_line {
>  		}
>  		$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
>  		        "<span class=\"section\">" . esc_html($section, -nbsp=>1) .
> "</span>";
> -		return "<div class=\"diff$diff_class\">$line</div>\n";
> +		return $diff_class, "<div class=\"diff $diff_class\">$line</div>\n";

What are these changes for, except perhaps to make the patch larger than
necesssary to make it harder to review?

It would leave an unnecessary SP like 'class="diff "' when all the arms of
if/elsif cascade fall off and $diff_class is left empty. It isn't a major
issue (I suspect that such a case might even be an error), and I even
think the code after the above patch would be easier to read and more
sensible, but shouldn't that kind of "style fix" be in a separate clean-up
patch that does not introduce any new feature?

> @@ -2307,9 +2310,9 @@ sub format_diff_line {
>  		}
>  		$line .= " $prefix</span>" .
>  		         "<span class=\"section\">" . esc_html($section, -nbsp=>1)
> . "</span>";
> -		return "<div class=\"diff$diff_class\">$line</div>\n";
> +		return $diff_class, "<div class=\"diff $diff_class\">$line</div>\n";
>  	}
> -	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1)
> . "</div>\n";
> +	return $diff_class, "<div class=\"diff $diff_class\">" .
> esc_html($line, -nbsp=>1) . "</div>\n";
>  }

And everything else, including this hunk to change what is returned from
the subroutine belongs to a separate patch that implements the side-by-side
feature.
