From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH 08/11] transport: connect_setup appends protocol version number
Date: Tue, 26 May 2015 22:09:45 -0700
Message-ID: <xmqqwpzuip2e.fsf@gitster.dls.corp.google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-9-git-send-email-sbeller@google.com>
	<xmqq1ti3j7ym.fsf@gitster.dls.corp.google.com>
	<CAGZ79kY=hZ=6pUbpVHUW8rU3AEMx2TwkBYDsDsZ+bPH_QnsYzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 07:09:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxTbF-0004rq-Cq
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 07:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbbE0FJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 01:09:48 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36283 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbbE0FJr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 01:09:47 -0400
Received: by igbpi8 with SMTP id pi8so75908784igb.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 22:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=J6nmGeDcMAa5uYnV+KDipF2GGc9rNBectjqn/EjXjXA=;
        b=FIQcBsGjB2PeFCpaSnwbhqUkJ2R6uvQeVMWDgmvyTEakBYzzhDm4AU1+BHiYlwh9/7
         gJyhoaluVdIzuX0szXDE+4CDDvSNZ2xUl43innyyt7XityvCupu7vfcOLTugHIx+WHQ9
         IX53eExkmzlCW52WGS8KkjrmYn+lWZoRLDOd9Rks6uOviVHuGmLBBukn9QxBpTCHx+iE
         5S1vhmu8bx2s3tAMWz1IlQnx05OIpP39lPW6GahFIWmaQXRL9JYf17UjPG0iwALGjFHM
         a70PNJUaKEI5FXZ2meKNlSBBpPtZZufs8g/9nxnIRS+J3AalYPlH+qbuCRjf4NpGBCtb
         mGog==
X-Received: by 10.50.30.9 with SMTP id o9mr1530748igh.23.1432703386990;
        Tue, 26 May 2015 22:09:46 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id j4sm1075235igo.0.2015.05.26.22.09.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 22:09:46 -0700 (PDT)
In-Reply-To: <CAGZ79kY=hZ=6pUbpVHUW8rU3AEMx2TwkBYDsDsZ+bPH_QnsYzA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 26 May 2015 15:31:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270012>

Stefan Beller <sbeller@google.com> writes:

> On Tue, May 26, 2015 at 3:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>
>>         if (...->version < 2) {
>>                 ... append "-%d" ...
>>         }
>>
>> involved.
>
> Oh! I see here you would count the current one as 1, which has no
> number extension, and any further would have a -${version}. That
> would transport the intention much better I guess.

Yeah, except that I screwed up my comparison.  Obviously, I should
have said "If version is 2 or later, then append -%d to the name,
otherwise use the name as-is".
