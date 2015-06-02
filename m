From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFCv2 06/16] remote.h: add new struct for options
Date: Tue, 2 Jun 2015 14:40:13 -0700
Message-ID: <CAGZ79kZ5q1bbHjVL3W6gT7QceQdza9+Lquu6vzcjO6vKeu7fSQ@mail.gmail.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-7-git-send-email-sbeller@google.com>
	<xmqqh9qp24hx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:40:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yztv1-00006s-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbbFBVkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:40:16 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:36301 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbFBVkO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:40:14 -0400
Received: by qcxw10 with SMTP id w10so65795866qcx.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Mp6cthhjdxg3Cx4LOrB/ljMdowI5V9CKMfD3vtW9OgM=;
        b=pZ14iYm8Up42XumP40rWw9/BQ6ujqIpu1ZwI6r6amHEyPNa84OW+2XfhPd9gZogpKE
         LtSuY/78kx6fhIrsgL/zhw/APyM4N2YS7GeE38v9m4hgnkWRibCnxptR5yjD4e+4/QAz
         1MO1797Nx56N1CAkwWXlKfvh7cloryfwUH+8Iva4JoDSTZoW0RMOR/mFi/knz+xWhOs3
         LSYZW4v39HwTStZZ97USLvJyqWSBNg5Y3WmPEfKMGc9jPgTNJjmLXFlwJUvqnID0kfnS
         Ql63jHyzXvF5ZtRIfbBWUPWhfgiLF4e8QfV9XVeJXE0xfMCvwQ+5qJPu/Xmcb5jE3QPk
         YHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Mp6cthhjdxg3Cx4LOrB/ljMdowI5V9CKMfD3vtW9OgM=;
        b=cVoWYtLUQh2ZlwXXdHfHQPDHOo9AHdMCcG6sdnwTT8iCYFIp4risArpyriPJt1AR9V
         D+M+ugg3UudT5SCT8FOlJYuB15JRsufV7Wk+6Zql4QWnO8Zog5BouoZq82+c/RQPqU8t
         SwE3hfn531dHRerwcuSxwJQSOOL6O710Pz7iUYbH4nU4oDpCrjZa4aD1tulOBm+aZ1SJ
         qMQ/qgISR6n46tE52c21+wt2oZSFRq0j3E/lGhirAxGDpCMC5CV50JbzmNiiVS8mp3AM
         81426SRGK+D6vMI+O3aRwYDPHXnDwgk+OOHFLefmChtfPoyr1LbH+xHav3AzFiFKlu2t
         NF9A==
X-Gm-Message-State: ALoCoQkAKXmV7q48EiqSTDw2msDKRGwcRWYAEWKCi2qWq/E+pG37MsLLJSBiFMxhMC/b4RTn6D0h
X-Received: by 10.55.22.143 with SMTP id 15mr52599776qkw.85.1433281213647;
 Tue, 02 Jun 2015 14:40:13 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 2 Jun 2015 14:40:13 -0700 (PDT)
In-Reply-To: <xmqqh9qp24hx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270606>

On Tue, Jun 2, 2015 at 2:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Why?
>

To have all options required for selecting the capabilities
together in one struct.

Currently there are independent variables used in a few places for this
(fetchpack.c: lines 296 - 309, which is where I also got the formatting from)

As soon as I realized I need to touch many places I thought about introducing
this struct.  But I guess I'll drop this as well as the patches
building on top of this
because it's actually only fetch-pack.c using it and it would have communicated
with the transport layer with this struct.

Maybe it is better to let the caller handle each option anyway, so that the
transport layer just invokes a callback at the caller (fetchpack or later on
sendpack) which immediately decides if it knows the capability and needs to
act on it.
