From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 14:11:14 -0500
Message-ID: <32541b131001131111u6bb0de01qe6cc1ecde5119084@mail.gmail.com>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com> 
	<20100113135753.GA7095@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:11:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV8d2-0003Ct-Eo
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 20:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab0AMTLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 14:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754867Ab0AMTLf
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 14:11:35 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:56246 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab0AMTLf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 14:11:35 -0500
Received: by iwn35 with SMTP id 35so16618723iwn.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 11:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=PTZfmNxQv9x68fyzq5rxILSD7xW2K7lhxLA6PPnxU/Q=;
        b=rq0tQV1PFYoiM/9UvTeKnjKQR2vepWST4NZqBcW/tcZc8CbXttytjOcnYfYShwwtTf
         JtrFCJwozI2kM5ykpBoWOYaR68+8vq59MxnwK+yHe1gzoiVvuvYYztACE9ORHMqNfAB9
         1FyP516YssF681m7vGJCBJflXzXzSARfFX3EY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OFhR7QrhGgig4KC0x0l2RbDr6uXq53Gw//Ye6pd2FDGJhwiZpQNQbFCU8dHnTyxgOo
         s0vteO0VRafaf/9T3Np0C4G01U/mL/Mn1NE3OH4/F0+SHQP7zKLCWxcRa7+amOam9Ad3
         XCJyf5r/NiBnG2dbODb1/mzcUGZqQpaJZ2cgk=
Received: by 10.231.147.210 with SMTP id m18mr1468894ibv.48.1263409894189; 
	Wed, 13 Jan 2010 11:11:34 -0800 (PST)
In-Reply-To: <20100113135753.GA7095@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136859>

On Wed, Jan 13, 2010 at 8:57 AM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Wed, Jan 13, 2010 at 08:39:12PM +0700, Nguyen Thai Ngoc Duy wrote:
>>
>> Can we rely on an external program, like stunnel, to do the job instead?
>
> No. The way authentication is done is very unusual. I don't think stunnel (or
> anything else) can deal with such modes. And the reason authentications are
> done like they are done in order to minimize points of failure (getting
> really annoyed at failure modes sshd introduced was one big reason for
> writing this).
>
> I _definitely_ do not want to mess with X.509. And its not just about me
> messing with it, it is also about pushing it to users.
>
> And one would need custom daemon anyway even if one used stunnel.
> git-daemon just can't deal with authentication data.

It sounds to me like you're doing two different things with this patch series:

1) Adding additional authorization features (assuming the user is
already authenticated) to git-daemon

2) Creating a TLS encryption layer with authentication support.

#1 sounds like it could be its own patch series even if you don't have
#2, and could be reviewed separately.

#2 sounds like it is not even git-specific.  You've decided that ssh
and stunnel don't fit your needs; what makes your solution not a
general TLS-based authentication layer, like stunnel but with
different certificate management?  If it's really a general layer,
maybe it should be distributed separately and git could be taught how
to use it *or* stunnel (or ssh, as it does now) for its transport
encryption/authentication.

Have fun,

Avery
