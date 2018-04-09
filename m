Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187001F424
	for <e@80x24.org>; Mon,  9 Apr 2018 07:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeDIH3g (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 03:29:36 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeDIH3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 03:29:35 -0400
Received: from arbeitsviech ([141.201.13.56]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0McWDw-1enuMD2oIi-00HgQ1; Mon, 09 Apr 2018 09:29:29 +0200
Date:   Mon, 9 Apr 2018 09:29:09 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [RFC PATCH 1/1] completion: load completion file for external
 subcommand
Message-ID: <20180409072909.GA30684@arbeitsviech>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq37059uez.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:3klpUPbZ4uF88m7L9FBWnyC81bteawPDYXYINojQNjt8P97FzCN
 1foVTvyIJdegXchKZx0+5Tbb/T3Fnyiw58dSqfJVTP6EYcqp29v2N4aa0j4peQT5GGHEMbN
 kDzo23gABtHCO5jRRPacdKdDYbce3wXndc0z8hcCIvCMER6LHfjgROpFmkmcQ+zZPqUqR4y
 Lrl/pbE+hRWjOqucBlqYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vbN/yl+e634=:0adWYRwGSrrReHpJanQ+ud
 1+c9mxVy+gjTk0622aPouK9GqTmZutxeu40z3FjjBYIZYp2aQV4nPYBocgnFoum4Y7BN5Lnqe
 4JNvPzva9BIhvFDtFAYxJ56TDrNa9hFfR8ZBb6GnObJtXit2KNmss9ImCdfvSntTpJMe7qEe/
 W0v2OMGjgKJo90oJ++v6pN/WJX6F+plLJjRE6GnFf7w91m/rMaZK8zbhLL2c3Zuupfubcekec
 FQTI60XBmRjzj5K6vmNW4y2KXp872XpB89Y/jy8qLFr1ZxMEXdUVthjVXEvuouNYULcKo54Jz
 0gbBN3AXtMHLZ50KKKhDfCkR16+1dGmyCjlkmayc3brodeFRKsiKbi0QVpq12xw0sKtDd9rHV
 3+a8FLL9kongV6ru/au1eUREOlkNtdXue3f5IZ+KKXA/zQ2266evPxhBTCaIHipxopEova35F
 a3MytOHUVabbGHZp4wFC4Z3e6jqUjUJ93ShCqIroHpSC2SzmgInGhadoRYhbKGRvcdjfZqlU0
 zWe3ZSEt47d5uS9zzomorUSOmmpUWWnaVN2L+MpwZu6vDhMYkFBy5oM6k0zBbJDrxZzK6CkuH
 Ap/B8lNq+WVtKnFpW+9qhWKm4Zw6VYmfG0JP8DShXALXD3d2df7Cr+aXZ5G6ipckAtzxuQu6Y
 3w6JfN+WNCjPfiEBydJ4Al6jJFG2CtuF5u/f96g9bk+hZsGfK+p853kJUqrMDusJxcy/UD+BA
 jeYwAp4XaQhphyxYwl1qrjEyjh0xLY28CHDCGQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-04-09 07:59, Junio C Hamano wrote:
> >  	local completion_func="_git_${command//-/_}"
> > +	if ! declare -f $completion_func >/dev/null 2>/dev/null; then
> > +		declare -f __load_completion >/dev/null 2>/dev/null &&
> > +			__load_completion "git-$command"
> 
> wouldn't the above be easier to read if it were
> 
> 	if ! declare ... $completion_func ... && declare -f __load_completion
> 	then
> 		__load_completion "git-$command"
> 	fi
> 
> or is there a reason why it is better to &&-chain the check for
> __load_completion with its use?  Same comment applies to the other
> hunk.

Good point. I could go even further and ditch the if-construct:

    ! declare -f $completion_func && declare -f __load_completion &&
        __load_completion "git-$command"

I originally intended to do a if-else-construct, which I re-thought
halfway through. I will change that in the next iteration.

Thank you!

-- 
Regards

Florian
