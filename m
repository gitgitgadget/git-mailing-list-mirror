From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: http-protocol question
Date: Mon, 1 Dec 2014 20:45:22 -0800
Message-ID: <20141202044522.GZ6527@google.com>
References: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
 <20141202033416.GY6527@google.com>
 <CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 05:45:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvfLA-00069g-V1
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 05:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbaLBEp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 23:45:27 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36082 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbaLBEp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 23:45:26 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so15725786igi.3
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 20:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=v33TFpF/4kuKsd9FiQwtN8KqpIAgfDo5ScOb086Zx8Y=;
        b=E2+tIYUrVQpItZWpg/6w3+jwJHp2JP2muyfCrP+9C7sev8V4mkBkEyXQbaX0stUCAz
         U7R1XvpunjGRL0HsapsCw0X2DUY3GWhavisJHk3O8l8EHq8Cp0Exb/Z9ATdr0AIfMfqm
         cWQaY4kDq2V5sNJ2o/lSKqQxLRN2rtRbN+MXaXUX1gFJq8YWRFVwPW4diy0j8TXwNcqF
         lPs4uIAkDcmAkTvlq0jS/uTzXpKbxtDqYeSIalK4XDYpLCue2+EQPVKJ87YYDssZvNe0
         oq549r1VOXftDS5gDE9R2DX8fPEIMdC/2xXoKSGQ5NrbacHLotFC06c/1MmsflRLARID
         zkZg==
X-Received: by 10.50.111.226 with SMTP id il2mr49468622igb.10.1417495525447;
        Mon, 01 Dec 2014 20:45:25 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:adae:4a7e:fb33:5785])
        by mx.google.com with ESMTPSA id l14sm10617680ioi.31.2014.12.01.20.45.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 20:45:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260531>

Hi,

Bryan Turner wrote:

> The reason I ask is that there is a race condition that exists where
> the ref advertisement lists refs/heads/foo at abc1234, and then foo is
> deleted before the actual upload-pack request comes in.

Can you say more about the context?  For example, was this actually
happening, or is this for the sake of understanding the protocol
better?

I ask because knowing the context might help us give more specific
advice.

Sometimes when people delete a branch they really want those objects
to be inaccessible *right away*.  So for such people, git's behavior
of failing the request unless the objects are still accessible by
some other path is helpful.

A stateful server could theoretically cache the list of objects they
have advertised for a short time, to avoid clients having to suffer
when something becomes inaccessible during the window between the
upload-pack advertisement and upload-pack request.  Or a permissive
server can allow all wants except a specific blacklist (and some
people do that).

Jonathan
