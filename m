Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 137572018F
	for <e@80x24.org>; Fri, 15 Jul 2016 06:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbcGOGqH (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 02:46:07 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37179 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbcGOGqF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 02:46:05 -0400
Received: by mail-wm0-f41.google.com with SMTP id i5so15587699wmg.0
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 23:46:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pjn+bA1/LkQw+166Bbwfh+sOSFlohyzt8chWVQRLs9c=;
        b=KCnELwsUkbG539IlbN/TtYa24usztH8ieClEhjl3mIXOMzSTmisj4J/sa7ieSkID+O
         N3Uectrw7V2PLraghe96abYqYVFTw70RoC6WGbSKUHQxWKLBRFAGL78HmSlmadKm2pnW
         3477vbvrNqIKaKhgby2Hv9EpZP0WDhMrk3W/wBVM9wdxIEgDKVwDvamJAo5KSFVg5fte
         rpRqA9UeTBkJPXvbqsSUS+1um8VraineWj+hW7p+j2Jplp7ngS0vkEjGGrid9Y7uuKQB
         jD5M4DXdd3mm5bPeskyKDbGVRrEM8UrucTA5ewpOKi6wbnnUJ/3Qz2GHl1viofTdNU35
         bNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pjn+bA1/LkQw+166Bbwfh+sOSFlohyzt8chWVQRLs9c=;
        b=flOeQVn6wNPfN0FOdxPFc8tecvd3ctZjjld39wmfsLbd5MfZpxPP3vhHI/N+peccXB
         hZgxwI7PZSyEj5SD9iinzMJ7f5Raa2j1mHuL2dH7Gct3wuwTcsbJdEIy6nSwarfV/jwx
         wVJBljV9pm/JVaG+NKhh5jamZBz6yhjlmM086eq/rxlQYtYN0DtSei8ndkbURMmpSpbq
         a0Wl/evC4l8g13W2w+joH80TXQLzRczn7ZSn6SAJXdKF8Ezhq+FzddEPGVbOmBDdv1LQ
         kvMZyTL96l111xXy3QtUGWzT77nDfY9lh5nlDE7vYhAaPgYcTT2u7kMg8bCgVXByBMya
         OdZw==
X-Gm-Message-State: ALyK8tL5LAbvcmBBr4ad1dEjX86HsUuULm3kNDLLB+iTKuOXvllCDgdgkaxoLPMNSP9eCSwU5i8syqrMXCeP5w==
X-Received: by 10.28.155.196 with SMTP id d187mr39077838wme.30.1468565164303;
 Thu, 14 Jul 2016 23:46:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Thu, 14 Jul 2016 23:46:03 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
Date:	Fri, 15 Jul 2016 08:46:03 +0200
Message-ID: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
Subject: Plugin mechanism(s) for Git?
To:	git <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Turner <novalis@novalis.org>,
	Ben Peart <peartben@gmail.com>, Joey Hess <joey@kitenet.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Ronnie Sahlberg <rsahlberg@google.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

It seems to me that there are many current topics/patch series in
flight that are about making Git interact with external code/processes
and that it could be interesting to step back a bit and see if we
could find a common approach/mechanism for at least some of these
current topics.

(This is also inspired by private discussions with AEvar, thanks to
him, and by the fact that I am now also working for GitLab on the long
run on external ODB for large file support.)

The current topics/work I can think of are:

- the ref backend work by Michael based on Ronnie Sahlberg's and others' work,
- the smudge/clean filters work by Joey and Lars,
- the watchman/index helper work by David, Duy and Ben,
- the external ODB work by Peff and myself.

They all have a need to talk to potentially different
backends/external processes and this need is potentially not well
satisfied by the usual mechanism that Git has traditionally used which
is to have one or a few commands configured and to just launch the
command(s) for each file or object, like what "git difftool" and "git
mergetool" do.

One reason that the traditional mechanism might not work well is of
course performance. This traditional mechanism still is very
interesting because it is very easy to setup and experiment with.

One way to extend it for better performance is to require that the
configured command should be able to deal with a number or a stream of
files or objects (instead of just one objec/file) that are passed to
it. It looks like that is what Lars wants for smudge/clean filters.

Another way is to have the external command run as a daemon, like what
Duy and David implemented for the index-helper.

And a more integrated way is to require the external code to implement
an API and to be compiled along with Git which looks like the approach
taken by the ref backend work.

If people think that evolution is better than intelligent design, and
want each current topic/work to just implement what is best for it,
then that's ok for me. If on the other hand standardizing on some ways
to interact with external processes could be helpful to avoid
duplicating mechanisms/code in slightly different and incompatible
ways, then I would be happy to discuss it in a thread that is not
specific to one of the current work.

Thanks,
Christian.
