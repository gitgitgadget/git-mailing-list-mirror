From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git grep broken in Fedora 21 update?
Date: Fri, 4 Sep 2015 15:34:20 +0200
Message-ID: <55E99DDC.2000900@drmicha.warpmail.net>
References: <9CAA4751-D295-4ACE-8ED6-720D728D24EA@intel.com>
 <CA+P7+xqzEHD9kR6suGBb1oXfPx0gehk7KYoUJFip_WcPWxTrPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>,
	"Rustad, Mark D" <mark.d.rustad@intel.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 15:34:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXr8j-00032x-Ga
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 15:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933086AbbIDNej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 09:34:39 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49696 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933420AbbIDNeW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2015 09:34:22 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id DBFD320750
	for <git@vger.kernel.org>; Fri,  4 Sep 2015 09:34:21 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 04 Sep 2015 09:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=1wwAYwQz7u4A8cOm1Gy9QcEivBM=; b=dYgwSs
	/i4emrdAQprlVlTmSPHvFD9tondk3pm2EP5N03LJSJkTl99TH1H4Mgw0myTbBbj6
	M+wztTZtQuJbvVSuvqzXZyx9Ia2oJ1vAf4CI1/oMN570EmWtprxqlNgEHqqA6Y6M
	4wdHPRIfQESYfX0TuvAlt1NyolJEnsvLOMgBY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=1wwAYwQz7u4A8cO
	m1Gy9QcEivBM=; b=P7XVqfvlnY8yt8o/7AQAOvf8NXwnlwr0hXf0xdYUi5bYxvO
	kWAeXHsrPKKTkaIPGbWGlR3zj4rNV78uGCKL9gPf38wgSctzw1V7nEAInIiQt6VR
	lRiif9CoAGa+PtHgRBJDoZl2WqnrldBTZP+WHi2kB74lGKCSAqDPBaYVngu0=
X-Sasl-enc: DcGDU4dckmFHdgU4IrV992Y2eOGzxT3hvBPzdS8xYxAB 1441373661
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4594BC00287;
	Fri,  4 Sep 2015 09:34:21 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CA+P7+xqzEHD9kR6suGBb1oXfPx0gehk7KYoUJFip_WcPWxTrPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277307>

Jacob Keller venit, vidit, dixit 04.09.2015 06:55:
> On Thu, Sep 3, 2015 at 5:04 PM, Rustad, Mark D <mark.d.rustad@intel.com> wrote:
>> I just found a case where grep and git grep yield different results. Inside the ixgbe directory of the Linux kernel I did:
>>
>> $ grep enter_lplu *.[ch]
>>
>> And got the following:
>>
>> ixgbe_main.c:   if (adapter->hw.phy.ops.enter_lplu) {
>> ixgbe_main.c:           adapter->hw.phy.ops.enter_lplu(&adapter->hw);
>> ixgbe_type.h:   s32 (*enter_lplu)(struct ixgbe_hw *);
>> ixgbe_x550.c:/** ixgbe_enter_lplu_x550em - Transition to low power states
>> ixgbe_x550.c:static s32 ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)
>> ixgbe_x550.c:                   phy->ops.enter_lplu = ixgbe_enter_lplu_t_x550em;
>>
>> But when I did:
>>
>> $ git grep enter_lplu
>>
>> I got:
>>
>> ixgbe_main.c:   if (adapter->hw.phy.ops.enter_lplu) {
>> ixgbe_main.c:           adapter->hw.phy.ops.enter_lplu(&adapter->hw);
>> ixgbe_type.h:   s32 (*enter_lplu)(struct ixgbe_hw *);
>> ixgbe_x550.c:/** ixgbe_enter_lplu_x550em - Transition to low power states
>> ixgbe_x550.c:static s32 ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)
>>
>> You can see that git grep missed the line in ixgbe_x550.c that had two hits on the string.
>>
>> This was with git 2.1.0 in Fedora 21. I use git grep a lot and never noticed a problem before. I just updated my Fedora 21 system yesterday, so I have to figure that has something to do with it. I checked and git didn't get updated, so I figure it must be a library that is really broken.
>>
>> I see in my update log that pcre was updated to:
>>
>> pcre.x86_64 0:8.35-12.fc21
>> pcre-devel.x86_64 0:8.35-12.fc21
>>
>> Yet the grep command is unaffected.
>>
>> --
>> Mark Rustad, Networking Division, Intel Corporation
>>
> 
> I don't know if command line grep uses pcre?
> 
> Does git-grep by default ignore changes not yet committed? That was my
> first thought but I am not very familiar with the tool.
> 
> Regards,
> Jake
> 

Can you downgrade pcre and check whether that's the reason?

Also, -14 in testing contains a few fixes.

Michael
