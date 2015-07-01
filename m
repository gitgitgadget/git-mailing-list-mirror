From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 40/44] builtin-am: support and auto-detect mercurial patches
Date: Wed, 1 Jul 2015 17:07:41 +0800
Message-ID: <CACRoPnQJqoXuWgQieTfgNCoA-b=21g1OgH9RzGFO5Q7dRhOV5w@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-41-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbO+f2iwTE0dG2zx09SAPR3KTt7T5sw5AFmLuNpo8HG3g@mail.gmail.com>
	<CAGZ79kbnxSD5bm_Bhjy8W2oY+1Mb=is_BcfbT5mGsb44fJE5nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 11:08:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAE0a-0000h0-N0
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 11:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbbGAJIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 05:08:40 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33678 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbbGAJHm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 05:07:42 -0400
Received: by wiwl6 with SMTP id l6so158066556wiw.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 02:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fdqWtjT7/MlZeMMa2kSdGF5DR6XW6Q7/JnJzTxeheR0=;
        b=yX5fmz3hMs8jf+hke61s7sX6N99yOrJ3NjdcHOkFlfen4ome5KprwIMsU+198rWe2/
         zU96CHY+idINB7qEF5Q7jVu34+0Qz86sYLG4Khqzs/goOhBXSbwEnnUqrqxCzcwcYSND
         c1O42T1W3LD1EFI71w+38EUoDojGhiZCvC4xxb5QzQy20Efrbkvp6qO/GTf5XnrUkScD
         +OYE1pDk1vZq3pufcIDERzla1+xEaPI4ZqheaQC5csntCR3zNvsGJTPagwgNl/ZGfSLJ
         s2WSSCOnM5ALbfemaXLWS2+hx6DsM0NkVRftAD+8WMA2O02N3RDAFZ4wHHasQ2jhbxUs
         3CgQ==
X-Received: by 10.180.11.239 with SMTP id t15mr4387861wib.63.1435741661443;
 Wed, 01 Jul 2015 02:07:41 -0700 (PDT)
Received: by 10.194.85.113 with HTTP; Wed, 1 Jul 2015 02:07:41 -0700 (PDT)
In-Reply-To: <CAGZ79kbnxSD5bm_Bhjy8W2oY+1Mb=is_BcfbT5mGsb44fJE5nQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273144>

On Tue, Jun 30, 2015 at 4:32 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Jun 29, 2015 at 1:32 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Sun, Jun 28, 2015 at 7:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
>>> +                       tz = tz / (60 * 60) * 100 + tz % (60 * 60);
>>
>> What happens if we have a negative input not matching a full hour, say -5400 ?
>> (would equate to 0130 in git)
>>
>> for calculating the minutes we would only need to take % 3600 (which
>> you do), but
>> then we still need to divide by 60 to convert seconds to minutes?
>>
>
> That said, I wonder if we have some helper functions around somewhere as we
> need to convert the timezone data at many places.

We convert timezone data at many places? Hmm, I thought all the time
related stuff was confined to date.c.

As far as I know from browsing around the source code, Git keeps the
timezone in the 24-hour format at all times, so there isn't a helper
function for converting from mercurial's "seconds" format to git's
24-hour format.

Thanks,
Paul
