Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71859C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 14:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DFE207FF
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 14:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Joef1hEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLJOJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:09:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:44925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfLJOJf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 09:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575986962;
        bh=b9HmsbuRXTqqIIf7z5t/RxMcjVJia3YFITdD8lmi0M0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Joef1hECghzkUHdyYkrAd7QL/0x2CnzGCIksijV/5oVGjPCeJNHAOyoHAj5+ugTb2
         rKOzhlmy8sh1yp2B5X2LenjlkLRb5m3VNUpGfk7CNUMr0ORxnFDlbt6e4aoUo4XoX/
         izuoQsKIp+vawgfhQgeeiyLTxAod3U4LBXrgiRdE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Ue3-1igd4a3ZVZ-0070Fy; Tue, 10
 Dec 2019 15:09:21 +0100
Date:   Tue, 10 Dec 2019 15:09:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 8/8] test-lib: clear watchman watches at test
 completion
In-Reply-To: <xmqqo8wgsqnn.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912101457200.31080@tvgsbejvaqbjf.bet>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>        <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>        <e51165f260d564ccb7a9b8e696691eccb184c01a.1575907804.git.gitgitgadget@gmail.com>        <xmqqwob5ru27.fsf@gitster-ct.c.googlers.com>
        <bfa73fab-ce2c-a05e-3568-cd406dd5c31f@gmail.com> <xmqqo8wgsqnn.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bcgb5GU21qszkbzcVQ0ziIfxMhXc4ESa5YkTO7Mpy96dTW2802x
 Ry5WyEORaJrPW0hphQ5TAT6jHwRGpJnV65mwy9Yy7glqOsWxv9FyQgtZAH6F4GoOp4Pxzbr
 5mTtjsDHln4aSw6U//5MNNaxCKRxoNl267y/SBTbN+O+5lQfT7KAEJXAfVIbHVH4glq0UZb
 ggNhIxMt1eErmTf4TYJkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ISCTTlcgH3M=:hI6wwOwuOMg0+8AMcM1Gp0
 McBXXC4oOrTDFC+GL4cq58TD/uNVm90zfrpwU9P34M3fjR1X4xytML5+nOCQsdajllrRsl4KH
 9GwJ5LkgsPuBsaPdjTYN5TrNEAUTyMYpgiOagcp5OeawG3Rj7SAzoL5imtwW950oDU3K+fK6b
 872d47OS/sOPb8NMDSXXuB09t4dBcbGg5njKVaijSn34Qo7+0BsLeu7QRKU2TIC81n20oWhLN
 zL7i0inK4EKp0bhfYmM+kGRh8tdb9TeoPPKfc2sGfQOsapCnlhsUg/O3zN6GWrTFsp5fg0w2C
 FptgXrj5elEqG3zQAMbSN/dpqzBAISWgpFsb5bpyRe1Z5kMVbbQBMOKRgoFVBaVJ3PLG9Wp3l
 QNWlkyOb6Mb/eEpiWKmNhhmqdZkv77iFcPTCz8sfo9WesATLIQqee5/KoPF/vqDacR8B6uHcF
 EqNPNjqOIlXB3Y5VFBMpiZj2HGSZgavDS12Ft3ttn5F+iKLxIJbnsRRCi8GUeEIb6vULc/xcU
 kh3mx0/AtC9HnZuNRakGQcjUrzB551k+9U6jlryYHQKxsggSzxgVECAeSY+k19Clx7PSDDo1L
 4Tjgehf1NqbOuxYeEZHu3LAm44it8V8DT3Bd9CzWNp+lEr3eIBwzP/48hmh5yxzFMijQfVUrQ
 vhCuU++bmG7XWoG1k1ixy+FOgZ3Y1QzC27wvI6SBAE0rONE0Ge7VukxM2fnxCCGnUqBSRzOfh
 aYiuvWQnhXTYiNWAD4Eo99ZnVyxYXqvX8QPnZo2a7jGK68JLYOf4Y5c6aTWDcWs8/ebIwhK40
 mNcpomq6vmc8GWBGEpiBm6ez503kKz51w96Q+hgdSTL2z35GlbF2b4wkg5xQepU1NePaEi/KI
 WB/bsOQ3anNQqRIVWW3KBny9Jbl3MoyZQmxmsvOZmo1bFIhuLA8EcQWKIbgfVnj05m5AQjGzM
 1eI6YlubV4AnxYwLDwuU0WYPedwVG9VOHLSC6K3Dxa8TeutSExQJMBfuB30y7A1ldtUltElwi
 DoR89KjDZGlV2PvmAg3kMHRrMIGqXRQVoSW5nwHTkdbnCRuaLme2eA4xigX0QQepQ8uoLaIaF
 gk+hU77NbqtSEqyv26yFHUMZpHZp5Mgd907BH/6rUPVpQU0bRirSrCXBWQm7HBmAyo29t+pA5
 oTzOGlriN6QLomwxuOpyJWYm7Ny50/jIKuG/a12rj2wU66NJJbltcF3pRbes8Lvxt3nkQnunc
 nQMr4QDVQ7gU3fbxA6348ZU7Kl4O7cLVka1aemLlBNcMzRCYHBpFI+ZRaXbA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 9 Dec 2019, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
>
> > Hm. That is a good point. Can we assume that our version of grep has
> > a "-F" or "--fixed-strings" option? ([1] seems to say that "-F" would
> > work.)
>
> $ git grep "grep -F" -- \*.sh
>
> is your friend ;-)
>
> And never use https://www.gnu.org/ manual as a yardstick---you will
> end up using GNUism that is not unavailable elsewhere pretty easily.
>
> > [1] https://www.gnu.org/savannah-checkouts/gnu/grep/manual/grep.html#i=
ndex-grep-programs

I often look at GNU grep's man page first and then verify via
https://man.openbsd.org/grep and
https://pubs.opengroup.org/onlinepubs/009695399/utilities/grep.html
that the option can be considered portable.

> >> What are these stripping of ", and " about?  Could you tell readers
> >> how a typical output from the program we are reading from looks like
> >> perhaps in the log message or in-code comment around here?
> >
> > Watchman outputs its list of paths in JSON format. Luckily, it formats
> > the output so the path lines are on separate lines, each quoted.
> >
> > For example:
> >
> > {
> > 	"version": "4.9.0",
> > 	"roots": [
> > 		"<path1>",
> > 		"<path2>",
> > 		"<path3>"
> > 	]
> > }
>
> Yeek; how is a dq in path represented?  by doubling?  by
> backslash-quoting (if so how is a backslash in path represented)?
> By something else?
>
> It's OK at least for now to declare that our test repository does
> not contain any funny paths, but in the longer run does the above
> mean that we somehow need to be able to grok JSON reliably in our
> tests?  It may not be such a bad thing especially for longer term,
> as there are other parts of the system that may benefit from having
> JSON capable output readers in our tests (e.g. trace2 code can do
> JSON, right?)..

From
https://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf
(section "9 String"):

A string is a sequence of Unicode code points wrapped with quotation marks
(U+0022). All code points may be  placed  within  the  quotation  marks
except  for  the code  points that  must  be  escaped:  quotation  mark
(U+0022), reverse solidus (U+005C), and the control characters U+0000 to
U+001F. There are two-character escape sequence representations of some
characters.

	\"	represents the quotation mark character (U+0022).
	\\	represents the reverse solidus character(U+005C).
	\/	represents the solidus character (U+002F).
	\b	represents the backspace character(U+0008).
	\f	represents the form feed character (U+000C).
	\n	represents the line feed character (U+000A).
	\r	represents the carriage return character (U+000D).
	\t	represents the character tabulation character (U+0009).

(Side note: It is amazing what things you learn unexpectedly, e.g. when
researching information about the JSON format, you learn that about the
word "solidus", that it refers to the slash, and that it was once also
know as the "shilling mark"...)

I am not sure why the forward slash needs to be escaped, but I guess that
this is voluntary rather than mandatory.

Ciao,
Dscho
