Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 163DF1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 15:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKNPH5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 10:07:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:34089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfKNPH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 10:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573744066;
        bh=XgQXO/jfHJHnxya7/8Gh6OaOGdwtUECIFj3NDE6uMbA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ObN7qA4yeQXMVeX2Ph/3wsV7rUGenOXWHcJfqqnoVPbypRumDG42B1GxkO3oa1ur/
         aUV7TO7QBrecHvWzB0QkLWaiiuJ5ss8f8fUs0mhqz7nzO6bA2uH1syx0BfJvjUhUit
         abH1L1masui6UO2U7hjrUeVO8ypkyNVPy4gYr4Wo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWici-1iOZgY0Bom-00X0o0; Thu, 14
 Nov 2019 16:07:46 +0100
Date:   Thu, 14 Nov 2019 16:07:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 1/9] Start to implement a built-in version of `git
 add --interactive`
In-Reply-To: <xmqqimnn9p9p.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911141602350.46@tvgsbejvaqbjf.bet>
References: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com> <pull.170.v6.git.1573648866.gitgitgadget@gmail.com> <5d9962d4344fa182b37cd8d969da01bc603414be.1573648866.git.gitgitgadget@gmail.com> <xmqqimnn9p9p.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:udHWiMREmOyQHYreJ9d3H57tshBEvWOfdQepkXuYDWWCdnlqRmJ
 zg7Sekt7YBVDTI+2+mhTj89cpXk0rt8o6Bduk7f9HxKqgrRl9aZUcn0+Fuag4DooPdsmDFF
 HVtaj9ZAElw/coKqPwHXxgMPnA5tJW3wZjT+JmIr6pn5PsgGu4l4sXbcRMQz776lGuY7zjv
 Ku2Z8v6LXY+fVSpdJoTKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nQG1fzkT5Vc=:2IRgxusjrqul/oeuBgvv2f
 lbRmaIzfhicGqB1Ah7heEI7GxoU/NxqWB7vptBJ9a9etC0TTcJERo9OYOI7xgsKeRqad1Nnew
 RbjdQDs/MOtCM866L8dqKWI4CEop/8mX/n62kjblO1ClweNNj/5K2SN1HSPIu+QDFZ8Zy0ivY
 awc6JoVI2m2KfLPnioHjWHqOAkUICa50JGuIAWShSo4CmGMmrbV8xPPIMkPK8e+oZlQfU4/sX
 I1flzux7WcWF8BJUTBUf4hJMjbgNiu0VogNuihD0roia4w7O+gUPk8vL2gTNczG1yvUZZdsPk
 WMBvNwiPcjBLvyQ3lGCTueJOjPL+9YVgS2/kupea14xQxHNLSWm7dvG35F64VlgzzWPhCkNM0
 yLv+bBCd988HyyOC7b5snQRyVI510+l3dbl4uvdNuLZCZRa2RxU6cTQMEk9/KO0LDQejJyuGj
 YY/JN2xHHrcrDX/5s2244JnvvhJghkPOtDaRNFS0CjPYvsoENjuNCJU+JJYUIokEaE/GUTsG4
 LvVRNW+hRdVkAH0+D9ShBR93x2e2k64njD/8SCKwMwiXersQb0hPjACDJrTtDX+/ra3rUgUEY
 nwuUD9eUNGT3HMR5MGfkGd4LrXcMoVES+NrK2MMhQ1EuA7W0OvtMbYBHoDHkvCIPe/yuJghxn
 +74scQ2OIDTSj8NuWuTN+zmsrg+pFLWhtOpNqm991+56VVfghcfouaihLBHCwcpP1ahCuHO3n
 H47wFrMzqazMQvn0UjoZZ55IQutRW8YmMWobXEjAjaNYWX0JesaigcpPPEVZlOR5K/OukofrE
 vxWzclMUYRncLKjEHt1VN7hMzWwzfmOnbfJXYNmzphm5vKcW+PCrHTgC3zltsHK3/ECv2ocpr
 YsF4v+2Z5WFSLIleY2vwzariQr1iz5+GCJD23TZ6VJklJoppB5iuI68zCkE/tghkD6xM0aMaF
 VdiwDcHuwaUML0a8GV4uYk8c3DLiwxalAOSxxwAOKNbpqJoAyJTu3gmGlLlJwFvGYVlnSzLfq
 YHI+mePHNnpqHzdcv2OAgABKaYcgXEEBLZZsSMqx1bLQyOpNoDYoaLtSDeNv9k09GDW8JiX2V
 sWo2VpAeIBLl9hVMewJXGFIFLsFwjt6XAInyTfoMqlrM4qfXGrSGAQoMNS8TcA9gowMLyklZC
 kGLFuONU9ycakIKeoZk6ToHFQ3ZsVHnw9yGfxJ74s3f7gSdXo4bxOXhYP5lF/NeQy0fUXE68x
 V9cI057m4mlerr2w1OndvuxsZaqIWVU3X+fCWoGo9z6I0qe+vVYLFrVseFWs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 14 Nov 2019, Junio C Hamano wrote:

> any case, I think I've seen the patches in this part of the metaseries
> enough and I think they are quickly stabilizing.  Let's see if others
> can find and raise issues and otherwise start cooking in 'next'
> sometime next week.

While reviewing the next patch series in this arc, I *just* noticed a
buffer overrun: in the main loop, `path + sep` might point to the
trailing `NUL`, but we assign `p += sep + 1;` at the end (which is only
correct when `path + sep` points at whitespace).

The fix is already pushed up into gitgitgadget/git#170, and the relevant
part of the range-diff reads like this:

    @@ add-interactive.c: static void list(struct add_i_state *s, struct string_list *l
     +					index = -1;
     +			}
     +
    -+			p[sep] = '\0';
    ++			if (p[sep])
    ++				p[sep++] = '\0';
     +			if (index < 0 || index >= items->nr)
     +				printf(_("Huh (%s)?\n"), p);
     +			else {
    @@ add-interactive.c: static void list(struct add_i_state *s, struct string_list *l
     +				break;
     +			}
     +
    -+			p += sep + 1;
    ++			p += sep;
     +		}
     +
     +		if (res != LIST_AND_CHOOSE_ERROR)

I plan on waiting for the PR build to finish, and maybe wait until
tomorrow just in case any further suggestion rolls in, then submit the
hopefully final iteration.

And yes, I think it is a good time to start cooking this in `next`, I,
for one, am prone to overlook anything crucial in those patches because
I have stared at them so often.

Ciao,
Dscho
