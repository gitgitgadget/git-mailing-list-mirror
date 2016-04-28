From: Luke Diamand <luke@diamand.org>
Subject: Re: BUG on OSX `git p4 submit` can fail when the workspace root
 doesn't exist locally.
Date: Thu, 28 Apr 2016 08:36:33 +0100
Message-ID: <CAE5ih78eGJN2kUjxfhUiKTAMK5rbTGZ-SFp405w2XRL6BDvwHQ@mail.gmail.com>
References: <CAMsgv2UXPkxpocjKhoR7HbmubSBnhJPJ3hMq9Jsk2AD0DoCifA@mail.gmail.com>
	<CAGZ79kZ6rx4UpPmeGjC8TyHKbVd+Y6i1JyEdDzKuF_9rj4c_7g@mail.gmail.com>
	<CAMsgv2W7mtJpFf6A4MZs-Sbvdof8EdOOP+uiGYudH8LUjNRo8g@mail.gmail.com>
	<CAGZ79kZX5H8ddhZQa4r9SPyhAYo=o6gBae3oPCYQ6iNtxXq1Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Smith <jaroslov@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 09:36:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avgV6-0006T5-T3
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 09:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbcD1Hgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 03:36:35 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35713 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbcD1Hgf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 03:36:35 -0400
Received: by mail-oi0-f65.google.com with SMTP id w198so7526867oiw.2
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 00:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=GzbClWFsggLFoaJU/FELOk+vHvyxddGKF1+nM8UJx5Q=;
        b=fCRwcnnIjs/gQUAfOIs0RI3Ntu5ahRnItMQ6Fpz69dPqGj/sh2jEvSMa/zBjjjiHwz
         vbqod0tXlLAZF8fTATN7uKDSpXqeUUGxizOyOIaVnxyhsRjtcDKEea9T7f/UWS5Kan+x
         3zmKcU0MvORHcpZ2NYeaspejvSTuy+NqIvnVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=GzbClWFsggLFoaJU/FELOk+vHvyxddGKF1+nM8UJx5Q=;
        b=dzXxektLdxrujyi/Iu3O2gtxptIe2prhHDPAtK4okUKANxtyNoiN4N0K3GQFVhsUfn
         ++oEVaFBZhcAfLHihYwrsQzBEk53DEx6fZjXytbw4bW72/ysXkCsjiMjvqvubN2oVddb
         sJzuFlnLvAYyVXoyAF24eSZvREk0yaD95f6ixw4MOspfwl7trmKwAEFjOD//9uDsVoPR
         3oPcuPKJkhyhDUUV+9n+KbvwnSWdpDNCdJjWil+KFGTUQkCipwSbma8AQu1BdsrgUCTZ
         AIpxNZ/8aoL6jF4yUkBL/+61uJ83eA9K903IbcrLCi+4d2hnstGPu3SigFnISP8pJkjE
         qiOA==
X-Gm-Message-State: AOPr4FUZ0CEJqUgM+Qxo7Q1Nz07Rhafy9KXIwpvCXh5FRUEQnvayw2xJn9xn6P5pfDDAnOtGBI3PXFcqpKQo+Q==
X-Received: by 10.202.77.146 with SMTP id a140mr5753364oib.86.1461828993699;
 Thu, 28 Apr 2016 00:36:33 -0700 (PDT)
Received: by 10.157.37.88 with HTTP; Thu, 28 Apr 2016 00:36:33 -0700 (PDT)
In-Reply-To: <CAGZ79kZX5H8ddhZQa4r9SPyhAYo=o6gBae3oPCYQ6iNtxXq1Cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292854>

On 27 April 2016 at 21:53, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Apr 27, 2016 at 11:06 AM, Jacob Smith <jaroslov@gmail.com> wrote:
>> I debugged the issue using the script here:
>>     https://github.com/git/git/blob/master/git-p4.py
>> I'm not sure how close to the main repo that is.
>>
>> On Wed, Apr 27, 2016 at 11:28 AM, Stefan Beller <sbeller@google.com> wrote:
>>> On Wed, Apr 27, 2016 at 9:15 AM, Jacob Smith <jaroslov@gmail.com> wrote:
>>>> On OS X,
>>>
>>> Do you use the Git as provided from OS X? In that case you better report the bug
>>> to Apple, as their version of Git is slightly different (not close on
>>> upstream, by both
>>> having additional patches as well as not following the upstream closely IIUC).
>
> In that case, I have cc'd Luke and Lars, who work on p4

Which version of p4 are you using?

Your suggested fix looks plausible though. Possibly it needs both
chdirs() so that "p4 sync" will work if the caller is using a
.p4config file in the p4 client directory to set the P4CLIENT.

Thanks!
Luke
