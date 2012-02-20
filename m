From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Mon, 20 Feb 2012 09:25:00 +0100
Message-ID: <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
	<CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
	<8762f9k5sg.fsf@thomas.inf.ethz.ch>
	<CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
	<20120215190318.GA5992@sigill.intra.peff.net>
	<CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
	<20120216192001.GB4348@sigill.intra.peff.net>
	<CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
	<20120217203755.GA30114@sigill.intra.peff.net>
	<7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
	<20120217222912.GC31830@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 09:25:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzOYW-0006Ia-Et
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 09:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862Ab2BTIZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 03:25:01 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54494 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab2BTIZA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 03:25:00 -0500
Received: by iacb35 with SMTP id b35so7225222iac.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 00:25:00 -0800 (PST)
Received-SPF: pass (google.com: domain of piotr.krukowiecki@gmail.com designates 10.42.145.131 as permitted sender) client-ip=10.42.145.131;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of piotr.krukowiecki@gmail.com designates 10.42.145.131 as permitted sender) smtp.mail=piotr.krukowiecki@gmail.com; dkim=pass header.i=piotr.krukowiecki@gmail.com
Received: from mr.google.com ([10.42.145.131])
        by 10.42.145.131 with SMTP id f3mr24201555icv.8.1329726300343 (num_hops = 1);
        Mon, 20 Feb 2012 00:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CWKKZCx1Llr9tv/7TSkIRSDdf1OI116H4qflzk58Xe4=;
        b=XUBo7UJhqUhneTTZmdjCK+KT+sRrk1KP13dR0Ofnxf+OWhhuDnpvZqy/tYrB9oP44f
         aMg78ekOrc679PD4WpnDN2ZUmPqiN578sZH3Fj1iWH0yw4p4NPwbG6Y0gfXkhf3qTR6d
         tIY+zoCpj8QMnyEmt+6FzaeMRD3BypHrrRJ5c=
Received: by 10.42.145.131 with SMTP id f3mr19448284icv.8.1329726300253; Mon,
 20 Feb 2012 00:25:00 -0800 (PST)
Received: by 10.50.46.33 with HTTP; Mon, 20 Feb 2012 00:25:00 -0800 (PST)
In-Reply-To: <20120217222912.GC31830@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191051>

On Fri, Feb 17, 2012 at 11:29 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 17, 2012 at 02:25:25PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > That being said, we do have an index extension to store the tree sha1 of
>> > whole directories (i.e., we populate it when we write a whole tree or
>> > subtree into the index from the object db, and it becomes invalidated
>> > when a file becomes modified). This optimization is used by things like
>> > "git commit" to avoid having to recreate the same sub-trees over and
>> > over when creating tree objects from the index. But we could also use it
>> > here to avoid having to even read the sub-tree objects from the object
>> > db.
>>
>> Like b65982b (Optimize "diff-index --cached" using cache-tree, 2009-05-20)
>> perhaps?
>
> That's what I get for speaking before running "git log".
>
> So yeah, we may be about as reasonably fast as we can go. Or maybe that
> optimization isn't kicking in for some reason. I think going further
> would require Piotr to do more profiling.

Is the cache set? Not sure how to check it. t0090-cache-tree.sh uses
test-dump-cache-tree and executes "read-tree HEAD" to establish the
cache, but in my case read-tree does not make the cache dumpable (but
it improves status performance).

$ test-dump-cache-tree  | wc -l
0
$ git read-tree HEAD
$ test-dump-cache-tree  | wc -l
0
$ echo 3 | sudo tee /proc/sys/vm/drop_caches && time git status -- .
[...]
real	0m1.085s


git version 1.7.9.188.g12766

-- 
Piotr Krukowiecki
