Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410A21F404
	for <e@80x24.org>; Tue,  4 Sep 2018 19:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeIEARe (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:17:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:47803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbeIEARd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:17:33 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LtIZH-1fllws1dkp-012sJV; Tue, 04
 Sep 2018 21:50:53 +0200
Date:   Tue, 4 Sep 2018 21:50:52 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] rebase -i: be careful to wrap up fixup/squash
 chains
In-Reply-To: <xmqqftypb44v.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1809042145470.71@tvgsbejvaqbjf.bet>
References: <pull.30.git.gitgitgadget@gmail.com> <0c9d0f75fc0dd28d55d4ed41d008182746fc86cd.1535759099.git.gitgitgadget@gmail.com> <xmqqftypb44v.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CnbJkMBW+zizR7Ptewtj2XAgWFLd8DuLB18lfytz/mR72JAbPf5
 gQbGNbZpjEOMKyOo5tQJL/JyBAsoL+9ecVl+4adUv9XpM6O3IxhZ0YyyBESi0z/r8ug/+r9
 4A/4bnhWtMr8NQvXQolnYzG8zZQhQzNW48DH+pS6rlXVPrwA+sB1PZRhEvA6EDaZfcMv24q
 l9c1PNYx5RKwszLiwraHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:umXPSj6aSKs=:5hLas6k+jqGQo9Mxs73mgX
 fCRsLxRIUmAcExOoA68ydwahs54QQLQnGQvV0rXRmvoGNxe+04STbCb3vxK0UyJ/B5L5SbViu
 htYO611Ob13ezyPiwoBi20eg073iNkqjlAunnWE/B+Hy6AfeUk16z04U12OkF1P6RQBUCAi6b
 Zr6BzuH5JFZyGSdS48kuFTgVqkRCV5t0JtF8CUrJG3BxZygYtfqv3nyMfRf7iZ3wcc1iAWd20
 cUKqBXivqrviAer/cwuxII7UPOyPWc1KHTwE0Nm41tkgFOEvqiLiiHhTBwMUlR0LJWa9AtuK+
 GhA0GEKGqPYSqj+jn6fy4Gz8Kd6D99GSgVQjuHPS3TOC4xNorVugSjoNKqptAIyMSgfW6MmDR
 OavEBF/cyrC9j5I563H+8BUT29pxdJOV6SqFWud/9dwXk4qMZsgMO2Zp3vLvLzvOLvhMyVQ+t
 ZFjKihJid15Ay9t4k9LR0PIWkKMol+5DMI9cSiwZuJ5JXDRYstTft7UZYEWSVfXc7uNvmzlmH
 SoHOql/Vkt/5o5I5JcptQTCRWruQM6HlZCC4xRQ/O98eVZxVVZ4+X2C1w3EHtr/yrSxTv5ZfA
 TKiM/v2K5MNtc4ZFadZqscJGQQZRHSGAPvh3hWgLKpN7A2+e9X0cTa1wRZ7dYj7IuVfxcPFnx
 P3SB1nmePHgh9+JlPgVdWUjbgVuNq/sWXTevPst3On9omHazcN6U5MDrStTRAC8xjMlcrkmzz
 SnivmO/GobrOO0z7KsWSSXBs8WwAoYZ05NVRx2odomPZ+az/tmiVC+dGNKwUAAVLYH8d6uLW0
 pVakg+a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 4 Sep 2018, Junio C Hamano wrote:

> > diff --git a/sequencer.c b/sequencer.c
> > index 84bf598c3e..ac5c805c14 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -3578,9 +3578,20 @@ static int commit_staged_changes(struct replay_opts *opts,
> >  		 * the commit message and if there was a squash, let the user
> >  		 * edit it.
> >  		 */
> > -		if (is_clean && !oidcmp(&head, &to_amend) &&
> > -		    opts->current_fixup_count > 0 &&
> > -		    file_exists(rebase_path_stopped_sha())) {
> > +		if (!is_clean || !opts->current_fixup_count)
> > +			; /* this is not the final fixup */
> > +		else if (oidcmp(&head, &to_amend) ||
> > +			 !file_exists(rebase_path_stopped_sha())) {
> > +			/* was a final fixup or squash done manually? */
> > +			if (!is_fixup(peek_command(todo_list, 0))) {
> > +				unlink(rebase_path_fixup_msg());
> > +				unlink(rebase_path_squash_msg());
> > +				unlink(rebase_path_current_fixups());
> > +				strbuf_reset(&opts->current_fixups);
> > +				opts->current_fixup_count = 0;
> > +			}
> 
> Let me see if the code is easily grokkable by (trying to) follow
> aloud.
> 
>     We used to refrain from going into this big else clause that
>     does the fixup-squash handling when is_clean is false,
>     current-count is not yet zero, head and to-amend are different

s/not yet zero/still zero/

>     commits or stopped-sha file is missing.  The updated code still
>     refrains from going into the big else clause under exactly the
>     same condition, but it learned to clean up the state, when the
>     _next_ one is not a fix-up, i.e. when we are looking at the last
>     fixup/squash in the current chain.  And the lack of clean-up
>     would have resulted in the next step misbehaving.

s/next step/ next fixup or squash chain, if any,/

You got the gist right.

> I see a few calls to is_fixup(peek_command()) and a local boolean
> variable final_fixup used in this function.  I have to wonder if it
> makes the resulting code, especially the above part, easier to
> follow and understand, if the function peeked todo-list to check if
> we are dealing with the final fix-up in a chain very early just
> once, and used it to see "are we doing the final fixup/squash in the
> current chain?" throughout the rest of the function.
> 
> 	Side note: I actually think that the existing final_fixup
> 	boolean means something different (iow, final_fixup is not
> 	set inside the new "clean-up" code above, even though we
> 	dealt with the last one in the fix-up chain, and that is not
> 	a bug---which means that "final_fixup" does not mean "we are
> 	dealing with the last one in the fix-up chain"), which may
> 	want to be clarified a bit with in-code comment near where
> 	the variable is defined for the function to be readable.

Indeed. The `final_fixup` name tries to convey "need to finalize the final
fixup", as in: show the commit message in an editor if any squash! commits
were included, and otherwise simply clean the commit message of all those
commented-out lines.

So that's very different from "is the previously-run todo command a final
fixup in a fixup/squash chain?"

> In any case, thanks for fixing this, which seems to have appeared in
> Git 2.18.  Let's fork a topic from maint, cook it in 'next' and aim
> for eventually merging it down for both 2.19 and 2.18 tracks.

Sounds good,
Dscho

> 
> > +		} else {
> > +			/* we are in a fixup/squash chain */
> >  			const char *p = opts->current_fixups.buf;
> >  			int len = opts->current_fixups.len;
> >  
> > diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> > index 7d5ea340b3..13f5688135 100755
> > --- a/t/t3415-rebase-autosquash.sh
> > +++ b/t/t3415-rebase-autosquash.sh
> > @@ -330,7 +330,7 @@ test_expect_success 'wrapped original subject' '
> >  	test $base = $parent
> >  '
> >  
> > -test_expect_failure 'abort last squash' '
> > +test_expect_success 'abort last squash' '
> >  	test_when_finished "test_might_fail git rebase --abort" &&
> >  	test_when_finished "git checkout master" &&
> 
