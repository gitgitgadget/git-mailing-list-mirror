From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 06/10] pkt-line: share buffer/descriptor reading
 implementation
Date: Mon, 18 Feb 2013 02:54:41 -0800
Message-ID: <20130218105440.GI7049@elie.Belkin>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092612.GF5096@sigill.intra.peff.net>
 <20130218104350.GF7049@elie.Belkin>
 <20130218104804.GB16408@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 11:55:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7ONL-0003y0-Sk
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 11:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab3BRKys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 05:54:48 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:46673 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab3BRKyq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 05:54:46 -0500
Received: by mail-pa0-f44.google.com with SMTP id kp1so2804302pab.17
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 02:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=hJC5zzMHscR3vPG6aGZ9vzluhJtO7od2P8qG9pyMr78=;
        b=knirDGFdSAx8DOC8vRbtpp+PqjFb3/jQ7mDmp/VOvX3oa6wGeQh9OXqreOmmZCpsEz
         Vn98mwB9O9werTwwkkNQe0Kv95a8prs9WvzYT+Qb4yj/YykeWsstc0cift5IC3SjGOXS
         jmDRZ56jzfneII7GRLEVFPNW16CMGTEDxeiG7rkx8zR3K1I7lTXkkAhFxinjn5Ye1wbH
         wYprve1U/T3hlAkiPMmmvdlI4VT2IKdQFHiyTGGmZuOXfLpuOLeSL5Wq4Fgh1R2wk2ha
         qdk1NODcjHJuMSgWNBSUGr4IatkpcVbt213MbiJHuO+a0KPPrDjSae/oe5b2iY8b665i
         8P1Q==
X-Received: by 10.68.83.38 with SMTP id n6mr28730197pby.28.1361184886426;
        Mon, 18 Feb 2013 02:54:46 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id y10sm14127778pbf.39.2013.02.18.02.54.44
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 02:54:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130218104804.GB16408@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216476>

Jeff King wrote:

> But is it noisy about a missing pipe? We do not get EPIPE for reading.

Ah, that makes more sense.

[...]
>>> +		len = packet_read_from_buf(line, sizeof(line), &last->buf, &last->len);
>>> +		if (len && line[len - 1] == '\n')
>>> +			len--;
>>
>> Was anything guaranteeing that buffer.len < 1000 before this change?
>
> No. That's discussed in point (3) of the "implications" in the commit
> message.

Thanks.  Sorry I missed it the first time.
