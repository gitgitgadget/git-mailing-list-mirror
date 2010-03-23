From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 7/6] Enable threaded async procedures whenever pthreads is 
	available
Date: Tue, 23 Mar 2010 22:42:46 +0100
Message-ID: <4c8ef71003231442j30618489n226dd16d4033c3fb@mail.gmail.com>
References: <cover.1267889072.git.j6t@kdbg.org>
	 <201003172228.18939.j6t@kdbg.org>
	 <4c8ef71003230115y64d36094y178fcfe6576e9c66@mail.gmail.com>
	 <201003232119.19430.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 23 22:42:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuBsE-00058D-4P
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 22:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab0CWVmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 17:42:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:49400 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab0CWVms convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 17:42:48 -0400
Received: by fg-out-1718.google.com with SMTP id l26so1226633fgb.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sxrHr/9uJBsDfsPsfQkaOZsAm9JYfCnNijQz1ljZUOk=;
        b=YpHb/JVUvCIVhYElFggId1ct9itFJZICk9urfPUyCs+zZQskPk5aUJgGtpwrjzY3bf
         kRzGnVX5YoKKqWKZ/p1jzlVnsP8mk1dbG5ObRS6mcZidlCk/kkm1xNO88VfVOffT3JOJ
         X5cibMDWfZ1L/7hkLe8ZiwaodwoDTlp+KuAk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iJ4KgaMacA7FJ2uBfN7EZ6YrYKOWait7RdCdOwD3LMGJPK7tGqn4BDDqUj/jRpDO6Q
         Fl1mB9utRydC9vl9cWNbdAiBzlFm4LzQtC7vKJU+Q21dtWGhvA3rs3gLGRXdNTH1WCzw
         SAzFIpMAtUFA3uX8IwKpsLPKtLUUnOpbMH8KY=
Received: by 10.239.185.129 with SMTP id c1mr2076564hbh.167.1269380566754; 
	Tue, 23 Mar 2010 14:42:46 -0700 (PDT)
In-Reply-To: <201003232119.19430.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143052>

On Tue, Mar 23, 2010 at 21:19, Johannes Sixt <j6t@kdbg.org> wrote:
> On Dienstag, 23. M=E4rz 2010, Fredrik Kuivinen wrote:
>> On Wed, Mar 17, 2010 at 22:28, Johannes Sixt <j6t@kdbg.org> wrote:

>> That xmalloc and xrealloc aren't thread-safe feels a bit fragile.
>> Maybe we should try to fix that.
>
> The point of this assessment was to find out whether this is necessar=
y (and
> whether something else that is not thread-safe is used).

It may not be necessary now, but my point was that by having
thread-unsafe xmalloc and xrealloc it is a bit too easy to introduce
new bugs.

>> > ----------
>> > upload_pack:create_pack_file():
>> ...
>> sha1_to_hex is also called by the parent and the current
>> implementation of that function is not thread-safe. sha1_to_hex is
>> also called by some paths in the revision machinery, but I don't kno=
w
>> if it will ever be called in this particular case.
>
> sha1_to_hex is only called by the parent when the async procedure is =
not used.

Yes, you are right.

- Fredrik
