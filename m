From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] send-email: do not load Data::Dumper
Date: Wed, 6 Apr 2016 14:07:32 -0700
Message-ID: <20160406210706.GK28749@google.com>
References: <20160406202538.GA27651@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 23:07:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anug2-0003XO-0m
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 23:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbcDFVHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 17:07:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33711 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbcDFVHp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 17:07:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id e190so5309655pfe.0
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 14:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q32sSC19i/BhCnQVRY4VSU+I5sBdyI1VeHhoTo1VWhU=;
        b=eb2YtqdlhW3piHOmZk8KNB8vT9OI3GwbXjnR2qLlGw3tl2Uub75tPHWzvSKE1ce5Y5
         k8NtgD88zLeRw1BbO1d6bvLP3cO8s0QA4muIx9yySHe3Z/za2ys72JVIYOze9FsYVliB
         Xdo1l3FdpZZDBeVChhCHareHGJ8ZseeQ/QCFZQNLDBhDWqkJeck0SlilI390tEnSL4HT
         CDBoQHr6wa4zXkeDVONAbke51wTCYzBwV5pqbjoMAEhkLC/mDklT1I1U2kTHc080N6YL
         hfmtXjsAOzALjveaVapo96ojK2sKDGCTRcCJIOHdfwvY8vSnPqRRFFTKIu5ZHWEzsJP5
         wCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q32sSC19i/BhCnQVRY4VSU+I5sBdyI1VeHhoTo1VWhU=;
        b=NT0ngSZXalFf2mA5nU4G3vunPDUxKpri1toCS/+wAqLkA4i1i6F7fyG2azP8SR7eDZ
         hkG+ciSFONMut4Qhgnzt/711AnzP/kJbWmBpbE0PE7fslqW1IpVK9ww77Ep/OFveLxrI
         WYZS4CQJB22igoPVdSYiVsIc/28WE309RNQqagZQ0C5RfJBQAwCQ5hLBwDu+Ytc8LB3h
         Y7+c7Mi/gv0M+wDn1WqbxjhOWatzUFRYtkmdP3ShDxdl+YYhixm/7227V9CWp95LZ+Yo
         rnI/H7NVtRQN2MRGBz5GOkxM/zwtzgprWOQWwmiNsICTX8GByY9o4b38OWPT/7Tr8ROg
         B1Fw==
X-Gm-Message-State: AD7BkJL26yhQ7DbztI3Po8PayH0LY/OwmofuT6FPNvUM/jggPMn5wdEXe7e6BJJHW1KKyQ==
X-Received: by 10.98.73.69 with SMTP id w66mr41297131pfa.106.1459976864513;
        Wed, 06 Apr 2016 14:07:44 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:e921:9e91:8d38:f26c])
        by smtp.gmail.com with ESMTPSA id g70sm7003043pfj.13.2016.04.06.14.07.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 14:07:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160406202538.GA27651@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290870>

Eric Wong wrote:

> We never used Data::Dumper in this script.  The only reference
> of it was always commented out and removed over a decade ago in
> commit 4bc87a28be020a6bf7387161c65ea3d8e4a0228b
> ("send-email: Change from Mail::Sendmail to Net::SMTP")
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  While I'm in the area...
>
>  git-send-email.perl | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
