Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F3C1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 13:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbcHZNqr (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:46:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:61428 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbcHZNqp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:46:45 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MWQSM-1bbcSs0n74-00XeVM; Fri, 26 Aug 2016 15:45:08
 +0200
Date:   Fri, 26 Aug 2016 15:45:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/15] sequencer: lib'ify read_populate_todo()
In-Reply-To: <xmqqeg5cjw02.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608261540470.4924@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <0de75bbce8ade0c6e5cf87d3647faa71a89c6275.1471968378.git.johannes.schindelin@gmx.de> <xmqqeg5cjw02.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:H+NCMgnlqPasAhzkTO2JW6czLu9VNw9yOjvJWR1OokAGlYm0C0Q
 Zpw8oDtDUfg1oGEAmuIzx8cacnKPzvVAJOxom5zjJO+uhTcgEwJT3LVBisuuSb9i4pMy94x
 7uTsaZvrYQAJ6KiaqA18Yenh4KBlZmbYu+NgHeloeQzTtntNUkAPxSVRN0piUwiJslBufwT
 zWnJ2ppNLN2e1+D/+YHFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nCHe6qDhqw8=:9t46z1yExx+zcrGC3l/OHl
 0rgFswKoIUtqUdI4i5Y21YpsjlsOZ8D+HbbPh7XLdZ+pR0xc93mVQ3xrFz/VSRnAtcOAkw+qK
 stDctgD0Lnugxfb4d83Iy9rJFVPJ+TpmJaB1kql7zupzvIkBi9BdhjHyHTAgwdOhjr5Mm3WJd
 kF/x2NuqXoEwvALx9Z+kofNcoboX2nwKNGWxmyPgMtZc6m8lDEr6EeFmm44Td+Cu+pJtabSyL
 6bVC7QmlLwYjXZ6YVMrxf1DwjWxw80wZDgENt8a9caVvBTg8JGk5CYWyESAadIwzhpkoFxKqE
 DM56GuK/9qfnHI2CjFO0CNP5SEOs2Jn+1avyqUoCNqnM4k8pZ0F86/569Y1TGzicsEoxXaLF6
 fqLipJNOljnMt2WP8haf7TSWSvyO6DF0ZEe/MVlQdvF4M0YzQZG/oRnDNU4sdy7CUVtU3K394
 +CNOneoeRGegdKru1J7X+XwAWzud+s5EDEl33tgvEjp6kxZ6a/+P47bcdyXxMIpN7KVLrIKC7
 Sl4TMujL2V1hxLoztbffUt/c4ySu2LTyI+wqiRkfewkIKPuOQL3gSS9ZWQVT215jHX+QsoBxx
 zcVIBZRtuZS+UVWKWd0A0s8lsPhmU7UuWoeWJfAWaolzt6NRN/mYNtGffrWx7dhfjE9wJLn10
 pCe5Xqoo9lDEOeDLqo0Wh2meBE/rdDDvmFfjSoxg20irKHhvv2pJDsod/CrbjkCXMW5eOdEgR
 862XxF3pFJrcDJG6sqZTx/cdfBL/Uq+m3zFVdZyBmtCZgZ85cDYS+cIOiteSZl2uT9d1SbUAT
 L+XB9oK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > To be truly useful, the sequencer should never die() but always return
> > an error.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> Instead of dying there, you let the caller high up in the callchain
> to notice the error and handle it (by dying).
> 
> The only caller of read_populate_todo(), sequencer_continue() can
> already return errors, so its caller must be already prepared to
> handle error returns, and with this step, you make it notice an
> error return from this function.  So this is a safe conversion to
> make read_populate_todo() callable from new callers that want it not
> to die, without changing the external behaviour of anything
> existing.
> 
> Good.
> 
> By the way, I am writing these as review comments because I do not
> want to keep repeating this kind of analysis as a reviewer.  I am
> demonstrating what should have been in the commit log message
> instead, so that the reviewer does not have to spend extra time, if
> the reviewer trusts the author's diligence well enough, to see if
> the conversion makes sense.
> 
> Please follow the example when/if you have to reroll.  I want the
> patches to show the evidence of careful analysis to reviewers so
> that they can gauge the trustworthiness of the patches.  With this
> round of patches, honestly, I cannot tell if it is a mechanical
> substitution alone, or such a substitution followed by a careful
> verification of the callers.

Duly noted.

I fixed up the patch order as well as the commit messages.

Now on to a request of my own: I am once again reminded that I have *no*
good mail client to serve me. (Before you suggest it: no, emacs won't cut
it for me, nor mutt. Thank you very much for your suggestion.) So it is
really annoying for me to scroll through quoted text, page after page,
only to find that none of it got a response after all.

In short: I would really appreciate it if you could cut quoted text after
your last response.

Thanks,
Dscho

P.S.: It's this mailing list thing again. I would *love* to switch to a
mail client more to my liking, but the ones I like all won't respect white
space in patch files that are pasted verbatim into the mail body.
