From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/11] Column display
Date: Sun, 26 Feb 2012 15:02:40 -0800
Message-ID: <7vaa45dwq7.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 00:02:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1n7B-00077n-Dt
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 00:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936Ab2BZXCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Feb 2012 18:02:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747Ab2BZXCn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2012 18:02:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BDDB73AF;
	Sun, 26 Feb 2012 18:02:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=n3PftPjrYM8g
	WmVMZe+2ccwSXns=; b=rKStu8Xq31h06Oo9oPYBYS/OIXSheUNMo1A4pfESbVhL
	RY7YygjIeMvgErrQPgH+bU84FOyXeacTicDo8LRJlV/zUIGXuKwQbse1ubwfr5BU
	Jf/XOTKF3z49nwzvbEAlhTT9MKAlkK7Is2STihXGZd7EtedykeGU2/GF48zC9Ro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=In81T+
	/NZLThjAtKjOPx9o0wc7340PYnbXFBalr250i6orWcKruWhTm7FHp6dLu6Imm8VU
	RGaZdV0fwMFhrX/gGwZo4154yaIj4q27QTZMqxOQtATkYqGbh9jQGaAQEBY/8f1k
	FdX1WbEMfB+8DMKH9gBdDFSBa5WlrAJ7PTBUY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9298973AE;
	Sun, 26 Feb 2012 18:02:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21EA773AD; Sun, 26 Feb 2012
 18:02:42 -0500 (EST)
In-Reply-To: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 25 Feb
 2012 18:41:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCABC9FE-60CD-11E1-91E2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191581>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (11):
>   column: add API to print items in columns
>   Add git-column and column mode parsing
>   Stop starting pager recursively
>   column: add columnar layout
>   column: support columns with different widths
>   column: add column.ui for default column output settings
>   help: reuse print_columns() for help -a
>   branch: add --column
>   status: add --column
>   column: support piping stdout to external git-column process
>   tag: add --column

The first one adds something that nobody uses, hence it cannot be blame=
d
by bisecting, but the "API" gets updated over time by other changes.
Perhaps the first two may want to become a single commit.

Other than that, the patch progression looks very logical.  The column
output subsystem gets enhanced using git-column as the scaffolding to h=
elp
testing and developing it, and then various commands start to make use =
of
the result when the subsystem has become usable in their context.

But I am very much reluctant to see us adding a "git column" subcommand=
; I
cannot justify it myself because what it does is even less connected to
git than the "--no-index" mode of grep/diff commands, i.e. it does not
have much to do with "Git, the version control system".

Shouldn't it be "test-column" that is useful during the hacking, much l=
ike
"test-date", "test-chmtime", and "test_credential"?
