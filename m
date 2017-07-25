Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27A512047F
	for <e@80x24.org>; Tue, 25 Jul 2017 10:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbdGYKTS (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 06:19:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:51839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbdGYKTR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 06:19:17 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHHZT-1dLwJ22SzD-00E9sM; Tue, 25
 Jul 2017 12:19:11 +0200
Date:   Tue, 25 Jul 2017 12:19:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] sha1_file: use access(), not lstat(), if possible
In-Reply-To: <xmqq1sp8fnxv.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1707251217250.4271@virtualbox>
References: <alpine.DEB.2.21.1.1707191450570.4193@virtualbox> <20170719171251.11906-1-jonathantanmy@google.com> <xmqqbmoekce5.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1707221309530.4271@virtualbox> <xmqq1sp8fnxv.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:N2FDkYDWBt0KkWLAKkl7KgasvifYdF0qS/BuzuGaj8wHtbHE6RI
 yP+TerYy0nSmNEcERR6X6r9VZ4C0/Lbnr9tQzlllWPthGoQFw8Uj5JYZYw65YO1BfbpEwUA
 PashULugAQiX+czEc5e08w8GXUpWltvRDb/qB7cYnlk2jU+f2gLU0nlyHPriZi8RrBDoUHK
 kp6atcBz6d+qKE7PV+AJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+OMEPCx5P0A=:MdDvLL+UpgXXuNHKoW0LED
 x3QQKGWjvkSxzpHFZXi8v4wN9jhskwhqTKMG/tG/4HZJdqSgotGSRO2mNmQuhncrV8Wbh3hoq
 wgmCV1Y3v/yKraF68vFW0C2oi3cCknP3eGHtOg0cV+qNvN4dJoD02fTMo++uEszfipRHF7cqM
 d7cOsO8aV6ig5bNbsFpkBNh04WRy94yQ+RITyyeLVfbfftFFjYP3Cxt55nceCDFG6gAPRHqEG
 MIHrHGFkFIuFGajElAz7VtmVeTsI9qL0FE/ZuRxmjzqCwdXqOOOTPzKtJiM0BN8xUMC8PoNVz
 FZA1Q9n7JH2u+USUoJ84DRLjomlEwdmCzNYQ1k/vVIIqcqOJaYTAP/HQ8o4UYA0We7OTWfSwR
 FG7VCn8+e4GLkN8QXd8FAeS8ISjJwzxblhQM1USF6PekLeLudzZE/cd3Gv4HPDBOzqYx8prbM
 GRWIhOEsqhxkRSwwxZKHDIs2hJsmrdzGet7Sp9MIjGTF6Fw5+i/JcnLMSXBRLrJvJz3LIwIq5
 oEjvgbpXG1UO67naVp3QwwTxy1K8aG6ZJS7ddxUSlgEnXUmhUqlVEvQ2onbMMVZ9ac9VSfU5o
 MJ7irkNVFMdM+95ubX08VRn+CY5CgqcHBtniQV5WSnUhYZKIN64IGzwp9HL9ZVUykuZwx5ZUt
 Nnbomyawy5zOOu81G9yl1/imVSbxhamghPk36ZH5t6FPQjKJfW7/KcJTcvLdfoOEotpwdSRmR
 o9BmNJb9ugzNgEmbekVRttKlz22y7Zkq13rDrAbjFjoP3Q6TRh36jAEmTMW5c8tfAVhIKn7oa
 RNWtmnBUcmtrISBPEwBCssyNlLTveii9d5lY7EziiQhmx2Vpb0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 22 Jul 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > But this whole thread taps into a gripe I have with parts of Git's code
> > base: part of the code is not clear at all in its intent by virtue of
> > calling whatever POSIX function may seem to give the answer for the
> > intended question, instead of implementing a function whose name says
> > precisely what question is asked.
> >
> > In this instance, we do not call a helper get_file_size(). Oh no. That
> > would make it too obvious. We call lstat() instead.
> 
> I agree with you for this case and a case like this in general.  
> 
> In codepaths at a lot lower level (they tend to be the ancient and
> quite fundamental ones) in our codebase, lstat() is often directly
> used by the caller because they are interested not only in a single
> aspect of a path but many fields in struct stat are of interest.
> 
> When the code is interested in existence or size or whatever single
> aspect of a path and nothing else, however, the code would become
> easier to read if a helper function with a more specific name is
> used.  And it may even help individual platforms that do not want to
> use the full lstat() emulation, by telling them that other fields in
> struct stat are not needed.
> 
> Of course, then the issue becomes what to do when we are interested
> in not just one but a selected few attributes.  Perhaps we create a
> helper "get_A_B_and_C_attributes_for_path()", which may use lstat()
> on POSIX and the most efficient way to get only A, B and C attributes
> on non-POSIX platforms.  The implementation would be OK, but the naming
> becomes a bit hard; we need to give it a good name.
> 
> Things gets even more interesting when the set of attributes we are
> interested in grows by one and we need to rename the function to
> "get_A_B_C_and_D_attributes_for_path()".  When it is a lot easier to
> fall back to the full lstat() emulation on non-POSIX platforms, the
> temptation to just use it even though it would grab attributes that
> are not needed in that function grows, which needs to be resisted by
> those who are doing the actual implementation for a particular platform.

It becomes a lot easier to fall back to lstat(), if a lot less readable,
yes.

Until, that is, one realises that the function name does not have to
encode what information is sought. It can be a bit field in a parameter
instead. There are even precendents in Git's own source code for that
rather smart paradigm.

Ciao,
Dscho
