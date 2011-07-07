From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 3/3] upload-archive: use start_command instead of fork
Date: Fri, 8 Jul 2011 00:25:00 +0200
Message-ID: <CABPQNSYZqpfGwgQXqk4YFBXhSHTen1w7m2hwaF7YDsZmsaYY5Q@mail.gmail.com>
References: <1310038989-5724-1-git-send-email-kusmabite@gmail.com>
 <1310038989-5724-4-git-send-email-kusmabite@gmail.com> <20110707191528.GD12044@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 08 00:25:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qex11-00010w-5P
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 00:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856Ab1GGWZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 18:25:42 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57058 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab1GGWZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 18:25:41 -0400
Received: by pzk9 with SMTP id 9so1067615pzk.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 15:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=59YnBcYNUAvfc1pqcLXSR5NskVDyPj+TdKYPlBpuZTM=;
        b=NozDVJjUup1RC3PQ+8isSR65HqAooz1os5gRJ8lsZfIvRyXq99KTrddTzNRgZSNuIT
         221HR+CiQXmOnKv3b0DDSe7z/oOIDEYO8RCxGpLWAGR4vwMsKBAhPGxkUnejwSHfkB0Q
         8mS1x0ZzqJkUodzlMjKVRV1c4uDv/4c6s2Ov0=
Received: by 10.68.40.161 with SMTP id y1mr1831990pbk.156.1310077540105; Thu,
 07 Jul 2011 15:25:40 -0700 (PDT)
Received: by 10.68.43.198 with HTTP; Thu, 7 Jul 2011 15:25:00 -0700 (PDT)
In-Reply-To: <20110707191528.GD12044@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176783>

On Thu, Jul 7, 2011 at 9:15 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 07, 2011 at 01:43:09PM +0200, Erik Faye-Lund wrote:
>
>> The POSIX-function fork is not supported on Windows. Use our
>> start_command API instead.
>
> Is start_command the right solution? From my reading, the fork is
> actually because we want to set up a sideband multiplexer. Should we not
> just be using start_async() to start a thread, as we do in receive-pack?

I considered that, but discarded it because I figured it required me
to plug through a file descriptor all the way through the code. But
perhaps I was wrong, and dup2 will make that job a lot easier?
