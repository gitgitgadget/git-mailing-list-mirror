Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23E1C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 14:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2FE20873
	for <git@archiver.kernel.org>; Wed, 27 May 2020 14:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbgE0O3w convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 May 2020 10:29:52 -0400
Received: from elephants.elehost.com ([216.66.27.132]:52237 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389033AbgE0O3w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 10:29:52 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 04RETaCi001546
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 May 2020 10:29:36 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     =?UTF-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>, "'Erik Janssen'" <eaw.janssen@chello.nl>
Cc:     <git@vger.kernel.org>
References: <1098602171.79502.1590528083387@mail.ziggo.nl> <20200527124445.GB2013@danh.dev>
In-Reply-To: <20200527124445.GB2013@danh.dev>
Subject: RE: [Feature request] Add -u option to git rm to delete untracked files
Date:   Wed, 27 May 2020 10:29:29 -0400
Message-ID: <021801d63433$3f0c5e80$bd251b80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF3XkBivtEXa9yvTaR7mLwAzbMragMQFSbRqWEoJMA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 27, 2020 8:45 AM, Ðoàn Tr?n Công Danh wrote:
> To: Erik Janssen <eaw.janssen@chello.nl>
> Cc: git@vger.kernel.org
> Subject: Re: [Feature request] Add -u option to git rm to delete untracked
> files
> 
> On 2020-05-26 23:21:23+0200, Erik Janssen <eaw.janssen@chello.nl> wrote:
> > Would it be feasible to add a -u option to git rm to specify that I
> > also want a file deleted if it is not tracked by git?
> > Currently, git rm -f can remove files in whatever state it seems,
> > except when it is untracked.
> > By allowing a -u option (-u: also delete untracked files) I would be
> > sure that the file is gone while it would also make sure that it
> > doesn't break past behaviour where people perhaps rely on git rm to
> > leave untracked files alone.
> 
> I _think_ remove untracked file is pretty much risky operation, and it should
> be done separately/independently (via git-clean(1)).

A git alias could easily be set up to do this, of course dangerous because of what git-clean does without any arguments:

    git config --global alias.rmu 'clean -f --'

> Let's assume we have -u|--untracked,
> nothing (probably) can stop our users from:
> 
> 	git rm -u src
> 	git rm -u .
> 
> Even git-clean(1) requires either --force or --interactive because it's too
> much risky to begin with.
> 
> If we think Git as a FileSystem, its rm should only care about its tracked file. I
> prefer to just rm(1) instead of "git-rm -u".

