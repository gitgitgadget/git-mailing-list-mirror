From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Mon, 17 Nov 2008 23:24:38 +0100
Message-ID: <4ac8254d0811171424t43676207v5d842ba8ab6e2944@mail.gmail.com>
References: <1226776980-9674-1-git-send-email-tuncer.ayaz@gmail.com>
	 <4ac8254d0811170237o78060cb3k4a64dceaa3a475d0@mail.gmail.com>
	 <7vy6ziy69h.fsf@gitster.siamese.dyndns.org>
	 <85647ef50811170303i17049994n356c384693502685@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 23:26:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2CXj-0003sQ-03
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 23:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbYKQWYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 17:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbYKQWYr
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 17:24:47 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:15274 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbYKQWYr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 17:24:47 -0500
Received: by an-out-0708.google.com with SMTP id d40so1160823and.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 14:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lJi9a2HbcbKeXK1ChfCYCYIzbT+mT8By6klqHobBHsM=;
        b=tZd7F+siS9jp29pK296mOms/ZUdyVY/OZyujOa6AV8mt6GyNxG41YIu8b6rSi3ubzn
         gUqwanFpTPGzazacepsv3kFYAbKE5VNnGvaYlgbcQcWMSIA759XCMiGZgB4bJunjTt7O
         que+6I5YgZ4zwBvQGL5DVV7iy6i9UvH5FsnO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=n0oULyRi6E5uGab5Rk3uvPbtwuOf+wxwamwStCAvtm9XQG7rdP9MA9CoOHzBcptSsP
         j38PduLBIb5E+5ZNrRSkPB4DcjOiRaTh+I2FQbCx96/ymWryULlJ8EC7lBFdVjyyszC7
         kQ4iaZXN0Iwz6vWTxf4A7xcRaVR+bZVLVTn7w=
Received: by 10.64.180.15 with SMTP id c15mr4241213qbf.80.1226960683523;
        Mon, 17 Nov 2008 14:24:43 -0800 (PST)
Received: by 10.64.119.3 with HTTP; Mon, 17 Nov 2008 14:24:38 -0800 (PST)
In-Reply-To: <85647ef50811170303i17049994n356c384693502685@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101253>

On Mon, Nov 17, 2008 at 12:03 PM, Constantine Plotnikov
<constantine.plotnikov@gmail.com> wrote:
> On Mon, Nov 17, 2008 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>>
>>> I think you need to have something like the following applied on top of
>>> what's in pu to be able to use "pull -v -v -v" and be able to count the
>>> occurrences via parse-options.c. What do you think?
>>
> I'm just interested why not just optional level argument to verbosity
> like --verbose=2 or -v2?

I'm not really sure which one is better but do prefer the
"-v -v -v" way as it seems to be common practice in tools
that support it. Also I don't want to make git cli different than
most other cli tools. This does not mean that common practice
is the best choice.

I think allowing an integer param makes our cli worse and
allows usage like --verbose=25. verbose=25 is not sane
in my personal view.

$ git pull --verbose # same as --verbose=1?
$ git pull --verbose=42 # will do the right thing always by AI?
$ git pull --verbose=0 # will do what? maybe quiet=1?

I say let's keep it simple so that no one starts getting the
idea that it's fine to have more than a handful occurrences
of -v or -q.
