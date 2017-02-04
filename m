Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E4BD1FAF4
	for <e@80x24.org>; Sat,  4 Feb 2017 10:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbdBDKnz (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 05:43:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:58514 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753811AbdBDKny (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 05:43:54 -0500
Received: from virtualbox ([46.183.103.17]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MhQju-1cnlZL1Ovi-00MbAr; Sat, 04
 Feb 2017 11:43:29 +0100
Date:   Sat, 4 Feb 2017 11:42:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] commit: Optimize number of lstat() calls
In-Reply-To: <xmqqd1ey5shc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702041142320.3496@virtualbox>
References: <DA0A42D68346B1469147552440A645039A9C9988@ORSMSX115.amr.corp.intel.com> <xmqqwpd678lx.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702040129430.3496@virtualbox> <xmqqd1ey5shc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wfY0LWmtdrqoyNAkXok4GluVDW0qNCip/G2u5ls0a9rfCP+GvT4
 DSIWXi8DKY0vhBkGcC5FNLWatYGWZJXa3OjHc2eZBzTzSGrW2sp2ouInihypx8r+bJGR36E
 /cqMIJ07nKbub125H+kJZ/OM+SQ+mU2OMkykOvs4DCv5HbVtKVgYkdXZoKHkvT+b2y4hjQ0
 kBeVulUAJv+pFdy8Lo7rg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QQ3cf3yKNkA=:jgMVKGAVE+eP/yXD1LFd0t
 V07raWkqLNN6Wjs6WPjwn0ysQiBhTzrezo0isjejsP6sG5SsJHJ21K6H8oLH4k1UCLBDmiQ1j
 AE/FIezvuEyPrCr15fiaDEdXBFI2fE2OCKL2zuZWh/7t8PSIw9uM/kFE9bFQwF6ygeb+8BCmG
 Jr4sj0kcLvsSjrMrm+G6bEaxpmLQCTogVEbIkC/4HQARKiQCIpM0s8ffTacTTpO/ZXx603dqj
 b1nsv3T+VH5ia8Od7IyS066yT1I2NwXCQRQ4WBNfIDSxGuoa8Z4xy6hSLMOo5iwcC/HwsHMic
 DchjqOJbqhIlekCOkwTpJoam4ZSOEvRhKydEdAszCI/Ftsd4r3iGOU2yoOeIHzarKK5GVmJbU
 6y9hCYdkDrRbcvJvF9OzNdYHqF7PfW2jkn1yLV95WjaT1K8IQnOmjMzkQfRFBKW09BxmowVFw
 L1NoOej153VlVhJSOtE8jedMkUx4Ky1I5Et8LTGN1uqSzXoJewCAmAGZf6fL5vw/P/QZv9KOQ
 OHWV9A3DaflQJfoAcVqZ94pD3pc/5ogWor5kMLsz/dG8FgpLbbQ7kS3FSsXvRYBbrJnJW1GGH
 IooVLXe1j3VxDfUN1oH6dyiVg1BeL6dKqQda0ayaq3MxihBEdLYTQa/+49Gbv83Qb1KJ9BkRO
 sbefDVOSPWMcvNKt8C2Mdklueyw0C4obIQnls+6peI/o5wWlyrsG2DSZq84CGF0tia+q40udS
 1Kq5np4z3c9BffNqXuIRzxzSupgSvFQBeVIxH9qtsEw7YsUybipVQdAjwSPzjhwWXOjBHUEql
 A0HFf5KvnJx74agKATwxte523EnqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,


On Fri, 3 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I could imagine that there is a third option we should consider, too: only
> > lstat() and update the paths that match the pathspec(s) provided on the
> > command line (this is the semantic meaning of the --only option, after
> > all: "I am only interested in these paths as far as this commit is
> > concerned"). What do you think?
> 
> I wondered that myself when I read the first message from Matthew
> and noticed that we always refresh the entire index.  But if it is
> OK to leave the entire index un-refreshed, that would even be
> simpler ;-)

Hah! You're right, that would be much simpler ;-)

Ciao,
Johannes
