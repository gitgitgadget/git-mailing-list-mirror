From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 14:33:18 -0800
Message-ID: <20140123223318.GB18964@google.com>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
 <CAJo=hJtQG_u4=SjPAgU8h4Wew9LjaXUxnHqTT3Q9E1=_5LJ6Sw@mail.gmail.com>
 <20140123202645.GA329@sigill.intra.peff.net>
 <20140123215325.GA28829@vauxhall.crustytoothpaste.net>
 <20140123220742.GA29357@sigill.intra.peff.net>
 <20140123221755.GA18964@google.com>
 <20140123222632.GA2311@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 23:33:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Sq1-0006Px-9i
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 23:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbaAWWdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 17:33:25 -0500
Received: from mail-bk0-f52.google.com ([209.85.214.52]:58683 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbaAWWdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 17:33:25 -0500
Received: by mail-bk0-f52.google.com with SMTP id e11so710271bkh.25
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 14:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OcnTYHoXrK64P+NjYuABRbPR+hyR13SXF+qAwhHiaHY=;
        b=Pm4savXx4tEWlM9cUyN2WU3PNZHm1Dkqq45qTYmkAGkYkaRMZR+OCq4BfYSKlwuVXd
         qyMDCeCJz6OK5yLULGETkg7qyDkM40MSJUiCkbYJ/12tKzIt1N1mUTWM6LUjKw+QGGLW
         2Ghk+8OAp5pjZpeZnIq+e8NELZv/n6HHptAyqcMno0iMnLVcFlVl7k63jpJQd2dLD964
         XYiA2xcm9Qxrmsfu5xoIAp/uXQYdHtIKNgBncKdoVgGT6jHkWH27F723xFkAIMy5UM1a
         EXbpYfbBgr+n0yd08AGj2FcIq95rQeGLK+xOlchg/Ge8pUCAZtGQNa0kde+cU2uvssd+
         vqYA==
X-Received: by 10.204.225.204 with SMTP id it12mr2298523bkb.107.1390516403819;
        Thu, 23 Jan 2014 14:33:23 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id tf11sm486241bkb.17.2014.01.23.14.33.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 14:33:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123222632.GA2311@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240968>

Jeff King wrote:
> On Thu, Jan 23, 2014 at 02:17:55PM -0800, Jonathan Nieder wrote:

>> I don't think that's a big issue.  A pair of 4-byte reads would not be
>> too slow.
>
> The header is actually two separate 4-byte values, so that's fine. But
> between the header and trailer are a series of 8-byte data values, and
> that is what we need the 8-byte alignment for.

Sorry for the lack of clarity.  What I meant is that a 4-byte aligned
8-byte value can be read using a pair of 4-byte reads, which is less
of a performance issue than a completely unaligned value.

[...]
> Anyway, this is all academic until we are designing bitmap v2, which I
> do not plan on doing anytime soon.

Sure, fair enough. :)

Jonathan
