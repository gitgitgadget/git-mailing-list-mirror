From: Phil Hord <hordp@cisco.com>
Subject: Re: ''git submodule sync'' should not add uninitialized submodules
 to .git/config
Date: Thu, 23 Jun 2011 16:01:43 -0400
Message-ID: <4E039BA7.8060302@cisco.com>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com> <7v7h8c4nv3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Maarten Billemont <lhunath@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Andreas_K=F6hle?= =?ISO-8859-1?Q?r?= 
	<andi5.py@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 22:01:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZq62-0005jK-ED
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 22:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933276Ab1FWUBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 16:01:45 -0400
Received: from sj-iport-2.cisco.com ([171.71.176.71]:47678 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759457Ab1FWUBo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 16:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1092; q=dns/txt;
  s=iport; t=1308859304; x=1310068904;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=kIZD1H7b+gj+myujPP3E2Pw/zkOZLKdg84fbCAk/xxQ=;
  b=GyujrWjvFW81xz9GslZ6DVPyU9xvQ0COvke03S0kZpaDTCJdjrIEoV+Y
   NzdIra2fYWhIPhgtiMK1b8nGCApCMYpmLPfCaBQaMip8srPbUbBKU9nIN
   2AjGHsQ4UHJknb45W52Z42rBCfSOgCiVahaokvG9fGfz4xXFbZISW5hGl
   c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAB2bA06tJXG9/2dsb2JhbABSpyp3q3adeYYtBJFyhGWER4Z+
X-IronPort-AV: E=Sophos;i="4.65,414,1304294400"; 
   d="scan'208";a="384673097"
Received: from rcdn-core2-2.cisco.com ([173.37.113.189])
  by sj-iport-2.cisco.com with ESMTP; 23 Jun 2011 20:01:43 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core2-2.cisco.com (8.14.3/8.14.3) with ESMTP id p5NK1hQ3024037;
	Thu, 23 Jun 2011 20:01:43 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7v7h8c4nv3.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110623160143129
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176291>

On 06/23/2011 10:35 AM, Junio C Hamano wrote:
> Maarten Billemont <lhunath@gmail.com> writes:
>> When I initialize 2/3 submodules of my git repository and do git
>> submodule update, all is fine: Only the 2 submodules that I need are
>> updated.
>>
>> When I run a git submodule sync to update the URLs that may have been
>> changed in .gitmodules, it ADDS the URL of the submodule that was NOT
>> initialized, thus "initializing" it.
>>
>> Now, when I run git submodule update, it starts checking out the third
>> module and my workflow is broken.
> See 33f072f (submodule sync: Update "submodule.<name>.url" for empty
> directories, 2010-10-08), which introduced this behaviour.
>
> cmd_update considers anything that has submodule.<name>.url defined as
> "the user is interested", so I suspect "git submodule sync" should not do
> this.

What about a compromise?  Change git-submodule-sync to skip submodules
which are not already initialized.

I have a patch to do this, but I need to test it still.  If it sounds
right, I'll try to submit it later today.

Phil
