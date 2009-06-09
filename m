From: skillzero@gmail.com
Subject: Re: git clone failing over slow links?
Date: Tue, 9 Jun 2009 12:58:57 -0700
Message-ID: <2729632a0906091258v7ec334faue725c71bdd11165c@mail.gmail.com>
References: <2729632a0906090852r124eff8eo8391ae90cbda5872@mail.gmail.com>
	 <alpine.LFD.2.00.0906091443050.31536@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jun 09 22:00:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME7Tg-0007R8-9Q
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 21:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003AbZFIT64 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 15:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755826AbZFIT64
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 15:58:56 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:26918 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729AbZFIT6z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 15:58:55 -0400
Received: by an-out-0708.google.com with SMTP id d40so280455and.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+9Z5n2B27Dj52W3KbkGkQxnslSSJehMbZT9JXxgIKMk=;
        b=nlIxfbQX4uZlOYo6XfwcB+UzFGsDkuNcRUG6WFr0m6desI/jKABtcn6dogjZ/8gWXp
         wwaa9wr5cPpvok3AZeaBADThrWB/9vHAL/rdBRnp2ZTvlVofX+zd2vYJr5xIjgtpzTzx
         abBUwT9t0rMGGKUAgz2c5U4TtlwIZAYTrZdIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lM4EBZsvKagrgHJGNqOybcbZfdigLi95b1QTg8jvTfMmi3I2bDYrXPCZ7ZHW9BIy4S
         bhfAIx6cwS2v2BmuvFxOrHdVAB9fyLX5RkrW/md2QHlB8V+08L3h0Kp/w0wIuI4e5Ogv
         NAump4xddv/D1aIhZZbrkiUIm3g18BYIyaTyA=
Received: by 10.100.168.18 with SMTP id q18mr484979ane.185.1244577537775; Tue, 
	09 Jun 2009 12:58:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0906091443050.31536@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121216>

On Tue, Jun 9, 2009 at 11:55 AM, Nicolas Pitre<nico@cam.org> wrote:
>
> Do you clearly have a set of people for whom the clone works and anot=
her
> set with issues?

Yes. Several us are able to reliably clone every time. A few users are
able to clone once or twice (maybe 1 out of every 10 times), but
otherwise, it fails when the server drops the connection.

=46rom what they said, it looked like read_in_full() (in wrapper.c)
isn't getting a full buffer. In two cases, 4077 or 4082 out of 4097
bytes. xread is returning 0 as you'd expect for an EOF.

> 147 KiB/s is not particularly slow either. =C2=A0What is fast enough =
for the
> clone to usually succeed?

Mine is 500 KB/sec where it always succeeds. I can try using dummynet
to simulate a slow link though.

> Also, since this is through an ssh connection, do you have anything i=
n
> your syslog from sshd (usually in /var/log/secure) about anything
> unusual for the connection to go down?

I'm trying to get that from the server admin now.
