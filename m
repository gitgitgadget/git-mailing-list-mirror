From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit --only -- $path when $path already has staged content
Date: Fri, 07 Nov 2014 08:57:11 -0800
Message-ID: <xmqqmw83gd94.fsf@gitster.dls.corp.google.com>
References: <545CA118.6040500@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 17:57:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmmqc-00063h-PZ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 17:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbaKGQ5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2014 11:57:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751317AbaKGQ5O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Nov 2014 11:57:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC1281A2CA;
	Fri,  7 Nov 2014 11:57:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=k9vDldqRE4VD
	QVgzqSoKH+or7xg=; b=idY3h3pbZ1qqpEyNkqKq1xRxL+v35E3X+6DfemXOfxn+
	HI29ogTFeiZILpHIX+JTqKcM8/jl2uqZkt9RcQkKPrBktCsvlj9C1F4VTZssNG5z
	UtaR3PeSnDiUVH9XlnmPjknsLIj9WTHNSbex5UZYAp4wOef2qfMyZMAKcpe9gKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Hw2UnZ
	kmAIy+ia4B8gC5/izKe0bSwiXTmKt2Lv9eeKmcWdkpFbXIVBox/uk962YwIs+8/e
	tNbRG9UiXc/UQdF4xKmSxTbNOD3wxTsfAXVHSPQQM0QBTbouuj1pLIYp7+GtX7V7
	IlTE+6+DAkzSBu9TyWvIHYlvo9q0gYssEYFtU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3D431A2C9;
	Fri,  7 Nov 2014 11:57:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AD331A2C8;
	Fri,  7 Nov 2014 11:57:13 -0500 (EST)
In-Reply-To: <545CA118.6040500@atlas-elektronik.com> ("Stefan =?utf-8?Q?N?=
 =?utf-8?Q?=C3=A4we=22's?= message
	of "Fri, 7 Nov 2014 11:38:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1EF4AC0E-669F-11E4-BE81-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:

> The manpage of git commit reads:
>
>   --only
>
>       Make a commit only from the paths specified on the command line=
,
>       disregarding any contents that have been staged so far. This is
>       the default mode of operation of git commit if any paths are gi=
ven
>       on the command line, in which case this option can be omitted. =
[...]

"--only" is as opposed to "--also".  Two modes of partial commits
are:

 - "--also" which updates the index with the whole contents of the
   given paths and record the resulting index as the tree of the new
   commit;

 - "--only" which starts from a new temporary index initialized from
   HEAD with the whole contents of the given paths and record the
   resulting index as the tree of the new commit, and then updates
   the original index with the whole contents of the give paths.

In other words, you give paths from the command line to tell the
command that you want to record the contents of them in the working
tree as a whole to be recorded in the resulting commit.
