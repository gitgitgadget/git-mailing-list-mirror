From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv1 0/3] git-p4: fixing --changes-block-size support
Date: Sun, 07 Jun 2015 17:58:46 +0100
Message-ID: <55747846.3060305@diamand.org>
References: <1433672505-11940-1-git-send-email-luke@diamand.org> <CALM2Sna_sdD_95MO3EbF0+QSpB9W1K8Rv3-TNOmnovWG57gh7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lex Spoon <lex@lexspoon.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 18:59:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1dv6-0008SE-0v
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 18:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbbFGQ7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 12:59:32 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38906 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbbFGQ7a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 12:59:30 -0400
Received: by wibdq8 with SMTP id dq8so61991047wib.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=MYhxbEbeJ3BP24ZfBtI67VqxWwkk1/e3PN+fYaa3OBE=;
        b=WF3LmXfCLjDIHsypR4pim+7yK1R5Re2787sERUrcdObh/w02QhLiImmnOhb7brRKBU
         0+OKTUdeVBOahUljo7rFuLxlyYfNLQpfl1vamq3S5miVpMjOu1SElasqSfHfkqlBJwBj
         6F47usC/uEt7wyZtcyazdKd2lSN99jX3saGJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=MYhxbEbeJ3BP24ZfBtI67VqxWwkk1/e3PN+fYaa3OBE=;
        b=e8TAuQvmX8W3t9kkJ9l7dEhpwmOE/8RguYJVenj7m8Fn7Z0YvmJHw94B07RCf9WWjH
         +oJxlNu+kq+mNO7h52T7H8heGmKqXTj+OMppddkrqdLqOM/5Q01CvdZ1WzmczluUyPr/
         ldMIJtU35cEXQQbRJmjtyPgEQRLKueIgWcPzh60XZLoWUTvTyw4u3MLCOM2PxGNBoeIt
         hGZ2Ma7eaGPyB+008mJSJH1odE+xMkP2Xe/+dJtPpb8N8q+OxtDPnPg5GmRLcz+VdBCb
         Nr1L1ZYX140fs9XeSyDgB4EqHUp59378OHwbCimtx+OgY+L30NFeiti6s0qvy70BrsmZ
         SsbQ==
X-Gm-Message-State: ALoCoQkaohOObpkW6+l7EYVr+XmaEuYmGnVez0J93j102o+UDLuXp9BGbK+0Elx9TYocnhVcvxOp
X-Received: by 10.180.160.210 with SMTP id xm18mr14286986wib.93.1433696369393;
        Sun, 07 Jun 2015 09:59:29 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id lf4sm255130wjb.42.2015.06.07.09.59.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2015 09:59:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CALM2Sna_sdD_95MO3EbF0+QSpB9W1K8Rv3-TNOmnovWG57gh7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270975>

On 07/06/15 17:01, Lex Spoon wrote:
> Great work.

Thanks! I actually found the problem in my day job, so it was very handy 
having all the infrastructure already in place!
>
> For curiosity's sake, the -m solution has been observed to work on at
> least one Perforce installation. However clearly it doesn't work on
> others, so the batch ranges approach looks like it will be better.

Yes, I can easily imagine that it's changed from one version to the 
next. I tried going back to a 2014.2 server which still had the same 
problem (with maxresults), but my investigations were not very exhaustive!

>
> Based on what has been seen so far, the Perforce maxscanrows setting
> must be applying the low-level database queries that Perforce uses
> internally in its implementation. That makes the precise effect on
> external queries rather hard to predict. It likely also depends on the
> version of Perforce.

Indeed. All sorts of things can cause it to fail; I've seen it reject 
"p4 files" and "p4 print", albeit with artificially low maxscanrows and 
maxresults values. I think this means there's no way to ever make it 
reliably work for all possible sizes of depot and values of 
maxscanrows/maxresults.

Luke
