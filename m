From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Wed, 15 Feb 2006 17:20:28 +0000
Message-ID: <b0943d9e0602150920y242a161w@mail.gmail.com>
References: <20060210195914.GA1350@spearce.org> <tnxy80fe2zo.fsf@arm.com>
	 <20060214045618.GA12844@spearce.org>
	 <20060214061406.GA13238@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Feb 15 18:22:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9QLD-0007Kb-0m
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 18:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946039AbWBORVU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 12:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946042AbWBORVU
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 12:21:20 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:31222 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1946039AbWBORVT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 12:21:19 -0500
Received: by xproxy.gmail.com with SMTP id h30so1056393wxd
        for <git@vger.kernel.org>; Wed, 15 Feb 2006 09:21:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YLFvwBMQRyNDOePJtrPlNB1gpTNN1XTHpYvRBgNvG92jzMD5uNvf/MJto4JccWVbtwLwt89wKmPaX6YLJo5F0+Obq0MMmecvXPU7ZhFJvRbOtUAu0rYa3U0BUpnK3rDfVuxHEb/5R8hE8U5PMHZ1YXIeZR48fxnvk9A9OC5oRtY=
Received: by 10.70.77.14 with SMTP id z14mr2941wxa;
        Wed, 15 Feb 2006 09:20:30 -0800 (PST)
Received: by 10.70.53.7 with HTTP; Wed, 15 Feb 2006 09:20:28 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <20060214061406.GA13238@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16249>

On 14/02/06, Shawn Pearce <spearce@spearce.org> wrote:
> The diff-tree/apply approach is faster for a single commit then
> read-tree -u -m is; even if totally different files are being
> impacted and thus all stages collapse neatly to stage 0 in the index.
> No wonder StGIT uses diff/apply!

For the simple tests you did the difference is not that big. It
becomes a real problem when there are many file deletions/additions in
the upstream tree since git-read-tree doesn't handle them and
git-merge-index would need to call the external tool for each of them.

To test the above, clone the 2.6.12 kernel version, create some
trivial patches and rebase to 2.6.16-rc3. StGIT was running even for 5
minutes per patch before implementing the diff-tree/apply method.

--
Catalin
