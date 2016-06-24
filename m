Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD032018B
	for <e@80x24.org>; Fri, 24 Jun 2016 18:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbcFXScu (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 14:32:50 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35235 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbcFXSct (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 14:32:49 -0400
Received: by mail-yw0-f182.google.com with SMTP id l125so106138529ywb.2
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 11:32:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eqzEeuRi2tduamHnRTRUftyyQUyw6uafCNpqZEXQ0Ig=;
        b=v2Wx1BQNUeqDZX/5fFyMkDr7Cji1zt+yK5Xo7y4cjYOmb0k45wHfFqYJPwSwRAcigq
         3iL+RLX5+wK0Waj19Vt98lEAuYqE8XtG54XsQ+vGLIuzBY4kFwlhKBJGvj2rAE2gbsDh
         8dZGxx7EtHXUd+X0CEPtJwjD8lSqKBfs/NLQekUMHNHf2vQUwjiUUaoMLHOaeQFT2xvi
         DBbzfKsEDlFBSUOl83o9vQkDFli/+TYs2/HnJQwVDXGoJq0FFyLKMgu6+EIklrDIdztn
         9SMTDS1YiV7fqkN3EgWnh5ut6lsg7Qn5viZmS+4nIHVCe2ydc11GqxZsVYp5zp7lEZJf
         Oi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=eqzEeuRi2tduamHnRTRUftyyQUyw6uafCNpqZEXQ0Ig=;
        b=g1dYhFhoUz84jXN8z3PRuxjO8FDstAeAfMvmKhxL4ZPytpkqo1CLJ5sI1MfyuMvCra
         /3jzm+yatLTzUZLGGV9XgB5/nkxYYopmrgJ+i9UjrlO7WIOlF+OlTfRTFJzLcybxCsIj
         N5zxd4D2addJuH0ox2ynB2w+Wx1G74Y6zX+8ZZurW56furjPxr3kuycB7CTw/mFftDWL
         zcyX/3yAwysqnVXPv2IBfS9DK9Sj88Pa7l4gWhqks84RNy9lh1CefrrvSIQUEEv0hcX9
         kqTfE97+Ob1iq9q+K988d9rsRVMjJ3NSZeuPqifIblXVEa3km2/fNbFVHwprr3lzP79Z
         hdZA==
X-Gm-Message-State: ALyK8tI9u/4pZMri9sSS5o2+mqixlyrqP5D7mBVIG4aAXcWalqFSCPTnxxxYc0FOlMXeLv7aa5k/+HxmPzvl9w==
X-Received: by 10.37.114.9 with SMTP id n9mr3827480ybc.80.1466793168319; Fri,
 24 Jun 2016 11:32:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.251.71 with HTTP; Fri, 24 Jun 2016 11:32:28 -0700 (PDT)
In-Reply-To: <20160624181414.GA25768@sigill.intra.peff.net>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160614210038.31465-1-lfleischer@lfos.de>
 <20160624153121.GA2494@sigill.intra.peff.net> <alpine.DEB.2.20.1606241942220.12947@virtualbox>
 <20160624181414.GA25768@sigill.intra.peff.net>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Fri, 24 Jun 2016 11:32:28 -0700
X-Google-Sender-Auth: _rmEQnOGn4uvyXEAAChij7svpus
Message-ID: <CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com>
Subject: Re: [PATCH v2] Refactor recv_sideband()
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 11:14 AM, Jeff King <peff@peff.net> wrote:
>
> I do wonder about the ANSI_SUFFIX thing, though.

compat/winansi.c seems to have a provision for 'K' (and obviously 'm'
for colors).
