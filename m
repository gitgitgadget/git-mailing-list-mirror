Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D5F51F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 08:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfJBIU7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 04:20:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:39253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfJBIU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 04:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570004449;
        bh=/wOfu1olSI2G3IRxPalhq13YbJ6UB8xf5iZ0ZU97Qrs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EWq/MqSjU8+w7p9RXjbK23vkLhGugNwNk/CyLCkqF6IYwha/TEckW6Fap1grRoi6+
         fnPO/8hpX0yz4YZFkLuK9QSMh9vXVpKnKS8TipZb1XFxGETUKm30d2LJvbH5gyz9LD
         xM53ooZZTl0ZugNQ3CKWV2TZ9j5QxPsJB2aZgSwA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTRN-1iRrPB3kqT-00NNQl; Wed, 02
 Oct 2019 10:20:49 +0200
Date:   Wed, 2 Oct 2019 10:20:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 5/5] sequencer: directly call pick_commits() from
 complete_action()
In-Reply-To: <212cdc0d-8cf3-9172-d405-39b3868e6ca4@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910021018360.46@tvgsbejvaqbjf.bet>
References: <20190925201315.19722-1-alban.gruin@gmail.com> <20190925201315.19722-6-alban.gruin@gmail.com> <212cdc0d-8cf3-9172-d405-39b3868e6ca4@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MQft/UGa6oUUsw+9+2IBMbgKN+I2PQf6wFWsc7JnyjRWYEwnRvi
 bltf3S8HfBAS6KO+Rb8F1KP4GaZWuBGmexd0RH+fXRMa+nPxW+gUc4PNMkr6udyb7VM3M0J
 TKEtrQLU6NbZwKCm5hd95bdR1PPyA3MWWRoH329wKW0xdtDhRdP13O36S5zFdC5plRO812K
 9L8UIGwYyPlHMACs+TrjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qRDnX2XfoiY=:48++D9SG6oC5YmTEEm94WQ
 qiors4YHVuxvll6P9D5v61l5VqbfNsSxT/xUDuqT3vA17NxmL6t/5c9cia6VFz01wZWSvADrM
 AQuDeq6KwyYGPbeh1iRipiljyo6wgIrHDhT0dBo0XbSyhif173mg4hz5K+8r6FO+ABmNlETuy
 03jeWv/W46ECE30S4ROx0B+YUUzMmqtMHU0J1XRuy4gxkTlPbcWpxVopN+OHHEbSOJ+tCMo6u
 83wIHOI/TP7fnpMLBP4Iium4t4ZMWtXGDO9J1S7H5hAqVgE6muvNLRWtyCS7GU0F0Zz0mRYLj
 pOx8E/9p5Ue+F0/6EDMwmBbJC5cqBITQlQLrSoZAL3Y+ugv+qKogGtY3e31oVihRIM685Qru7
 JMwNtM+SiR4HeFR2vD0k2zG72k0Dbj7u0h9Lpy95lgKQQDEkFd1M+rJKmR1cfBJzKPefrp5GL
 8g0uSNFmVSL7kqq6n9sn30aAJPIPdEsbGD4mJJeqUSytdzu60T1CeeRDIOA4CHzpiMoI6CBGQ
 JFIdCBuRWgOfJ68XlUGU2IyAOKH+eEts5/4ss7Iv96D2WxwJMHbkyi1KM/daLSViF2oBSfu+N
 DOopGblzrY8R4KhDBJ5phdQjBPujMQzyakrRFtrkiQBCOYAsU2NpSmSsJbgOlGElu45f2Fig8
 obkpNnlj/Qlay0wFBVYNfpyuJossT8dXmN0FXhM56Ye7i/tsfOg72TNmiyUrgV+aJMLNqJTRF
 ZLvhF1wvIEXlEkjR4lC8AuoViw59vttRNkU72nAJGOo6cHe3a0RUFApT5hIGrz5I2KCuGnMmw
 V7jGzKyZ4f29uZYNMJFJ6baUmOnvYJou7/WWh7oGccZoKqPRbJ7XdTMELCRNNzGqDfI0Ym/S+
 8onDIeehPCOm8yzsn61LE+Y3+PB/4n5SdWGpuNNHnL8UsT6kkYPKzIDEXfUmP4JmQIalXU0DG
 39thCWrOpjcu9hs81ABZ0hH6hZ7IgopU9yyBml3sUZE8+K0RQgQBUbCIX+qdj4Drhf+izHgMS
 kijKm/zyrK46h6ZsYm/gKmKOL0/3Mk+f7eKCHI23YMTZ70nmMn7QqnTcQW/nCx0dVw5vvDdD+
 m0cNS0FAwimUkD8KA0mKt0uWdob9sM46p/5qWWUYoFfnSgzqijfW7aUnhWZlRsmVAKefnjEwI
 waPSBuJ6tGtSeQE4fcS5GyvZGRepcrg1oxFbNbZzlsPSbyzr2oHYUWMuJPDtzrFcNCGFZSqGG
 IIgvbaiOUNm4Mw61GADW/O73u0nu04QtoK8RsiuvtqAHH0gdyvr2gxpcHbMM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 27 Sep 2019, Phillip Wood wrote:

> Hi Alban
>
> Thanks for removing some more unnecessary work reloading the the todo li=
st.
>
> On 25/09/2019 21:13, Alban Gruin wrote:
> > Currently, complete_action() calls sequencer_continue() to do the
> > rebase.  Even though the former already has the todo list, the latter
> > loads it from the disk and parses it.  Calling directly pick_commits()
> > from complete_action() avoids this unnecessary round trip.
> > Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> > ---
> >   sequencer.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index ec7ea8d9e5..b395dd6e11 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -5140,15 +5140,17 @@ int complete_action(struct repository *r, stru=
ct
> > replay_opts *opts, unsigned fla
> >    	return error_errno(_("could not write '%s'"), todo_file);
> >    }
> >   -	todo_list_release(&new_todo);
> > -
> >    if (checkout_onto(r, opts, onto_name, &oid, orig_head))
> >     return -1;
> >
> >    if (require_clean_work_tree(r, "rebase", "", 1, 1))
> >     return -1;
> >   -	return sequencer_continue(r, opts);
>
> sequencer_continue does a number of things before calling pick_commits()=
. It
>  - calls read_and_refresh_cache() - this is unnecessary here as we've ju=
st
> called require_clean_work_tree()
>  - calls read_populate_opts() - this is unnecessary as we're staring a n=
ew
> rebase so opts is fully populated
>  - loads the todo list - this is unnecessary as we've just populated the=
 todo
> list
>  - commits any staged changes - this is unnecessary as we're staring a n=
ew
> rebase so there are no staged changes
>  - calls record_in_rewritten() - this is unnecessary as we're starting a=
 new
> rebase
>
> So I agree that this patch is correct.

All true. Could this careful analysis maybe be included in the commit
message (with `s/staring/starting/`)?

Thanks,
Dscho

>
> Thanks
>
> Phillip
>
> > +	todo_list_write_total_nr(&new_todo);
> > +	res =3D pick_commits(r, &new_todo, opts);
> > +	todo_list_release(&new_todo);
> > +
> > +	return res;
> >   }
> >
> >   struct subject2item_entry {
> >
>
