Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3BB1F667
	for <e@80x24.org>; Sat, 12 Aug 2017 11:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750998AbdHLL5c (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 07:57:32 -0400
Received: from mout.web.de ([212.227.15.14]:50629 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750872AbdHLL5b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 07:57:31 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lrb4v-1dUQDG2o0r-013Mbv; Sat, 12
 Aug 2017 13:57:07 +0200
Subject: Re: [PATCH] strbuf: clear errno before calling getdelim(3)
To:     Simon Ruderich <simon@ruderich.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Yaroslav Halchenko <yoh@onerussian.com>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
 <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
 <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
 <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de>
 <20170811075059.nn6lru7uy6s6vpza@ruderich.org>
 <e8e7f028-6e23-368c-484f-9f069bae5dc8@web.de>
 <20170812100252.bhbgg5jjlom7dfl2@ruderich.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <510f566b-3aee-98fd-9663-d97c3dcfeb96@web.de>
Date:   Sat, 12 Aug 2017 13:57:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170812100252.bhbgg5jjlom7dfl2@ruderich.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:hmiu7224VgTN6NUP41aLLybl5Y2GEODVPuP8L3Sf+IKbsKM08Qy
 cFM0mfW9m4FQkkQU4YS79z4K8/6aFX9aiP/EtyUt3azRWO0zpXZwIEjVs6Hdb6lkCKv1vW1
 NqevkdgksB0j1kJ8SjvaMs7RtIxcXywuS6RtDA7iMsTeCfo2f+XDAGfqL9+rsgEHW2qIu6y
 j8X57YjtHJVfnQRYP7rMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fmN4wsF4QCY=:CSF9yklIgPMdGYrx7fJ/Fg
 3Y4YtfVqcA73isNfeulNW1KNjul3l4oEhk22T0qR1fPs0TszD+kIefDAelO2kVNq8IBEgAJf8
 1WaxvFUtr0u8EoW9N28MLWzUa2VJuP6ii+l7Apv/fXZfOMnLE5ttsQyLT/9dyAS7c2XE0Fivc
 TqkvPSlMwr+7bKbVD/L9FrG64WVvG4A3dnkPnKbhUHpu+T0HTrAce4eRUORXkCGBvvkYNoDaI
 bZ7trwAujpzlWPDudjJXMkxW6dmGtrF4aSTB8m4vLGneixYPwG0WbRO0wWXXslQeUTF+gfZKv
 ZxkllIHPLz3cyj/P92ye9423GDZmdlwQ+a0xt+rcvkU94CvduRUhmg6272tjtDWwjrbPgf1XX
 xlOpXgOopsAJko2k9FvzAKOYvIOlx7ZuLy4DAnVdrcsirFrHBckjqGfrZfrytf9EHinRukHXI
 vuyGUO/s+KDfFfbkfDKgdPpubJ1gwfERQAk0EyzCZATSOGV3yNqBUdABnYDuuj9F6isFEvLxc
 twmfYpMglXgx1uXLjzZhX2v2S1gii0eFj5Fp3tB9uw4oKr5iAI3XzRniQb8dNVtOXa8i+XAGF
 TQEBhglGCskmza3QQ00eDoXCYgpp0X9UUNDAjNwStWCghwReX3dD22Ay5gJh6tsw/FcTWzS7Z
 EGA/SK7ofO34GxXCDWSA7tY7lNrih9RKLsQmhJrqdu5zH2C9hRlgp/NPmNRgGkBNjlGXGVHhA
 8OYzEqs5CVP9GPpUzT9DUrFavtdPbr80NY+ZYeQWCtqbVJMnafiGUH3YztO6nnKtotgxAgGT8
 77RqdElce367qTChOmFcu3sjBpTx49dvhZA7baT9ztdMZGVrlQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.08.2017 um 12:02 schrieb Simon Ruderich:
> On Fri, Aug 11, 2017 at 10:52:51AM +0200, René Scharfe wrote:
>> Am 11.08.2017 um 09:50 schrieb Simon Ruderich:
>>> On Thu, Aug 10, 2017 at 10:56:40PM +0200, René Scharfe wrote:
>>>> getdelim(3) returns -1 at the end of the file and if it encounters an
>>>> error, but sets errno only in the latter case.  Set errno to zero before
>>>> calling it to avoid misdiagnosing an out-of-memory condition due to a
>>>> left-over value from some other function call.
>>>
>>> getdelim(3p) doesn't explicitly forbid changing the errno on EOF:
>>>
>>>       If no characters were read, and the end-of-file indicator for
>>>       the stream is set, or if the stream is at end-of-file, the
>>>       end-of-file indicator for the stream shall be set and the
>>>       function shall return −1. If an error occurs, the error
>>>       indicator for the stream shall be set, and the function shall
>>>       return −1 and set errno to indicate the error.
>>
>> [snip]
>>
>>> I don't think that it matters in practice, but the "most" correct
>>> way to handle this would be to check if feof(3) is true to check
>>> for the non-errno case.
>>
>> Only if errors at EOF are guaranteed to be impossible.  Imagine
>> getdelim being able to read to the end and then failing to get memory
>> for the final NUL.  Other scenarios may be possible.
> 
> Good point. Instead of feof(3), checking ferror(3) should handle
> that properly. It's guaranteed to be set by getdelim for any
> error.

Only if we have a POSIXly correct implementation of getdelim(3). On
Linux its manpage doesn't mention the error indicator, but says that
the function started out as a GNU extension before becoming
standardized, so I'm not sure we can depend on that everywhere.

But we probably want to check for other errors.  They look unlikely
enough that we may get away with something like this:

	-	if (errno == ENOMEM)
	-		die("Out of memory, getdelim failed");
	+	if (errno || ferror(fp))
	+		die_errno(_("getdelim failed"));

NB: The other errors are EINVAL (input pointers are NULL or the
stream is invalid) and EOVERFLOW (read more than fits into ssize_t)
according to POSIX and the Linux manpage.

Update: Just noticed that on the BSDs getdelim(3) doesn't set errno
to ENOMEM on allocation failure, but does set the error indicator.
That might be an oversight on their part, but that means we
certainly *need* to check ferror().  And an unchanged errno can
mean ENOMEM there.  Ugh..

> An edge case is if the error indicator was already set before
> calling getdelim() and the errno was already set to ENOMEM. This
> could be fixed by checking ferror() before calling getdelim, but
> I'm not sure if that's necessary:

Treating an error as end-of-file is not a good idea.  An invalid
stream should not be passed to strbuf_getwholeline() in the first
place.  We could call die() or BUG(), but I think we may leave
that check to getdelim(3), unless we learn about an implementation
that is unprepared to reject streams with the error indicator set.

René
