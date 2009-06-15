From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] daemon: send stderr of service programs to the syslog
Date: Mon, 15 Jun 2009 12:06:01 -0700
Message-ID: <4A369B99.4030504@zytor.com>
References: <200906142238.51725.j6t@kdbg.org> <20090615145716.GW16497@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 15 21:06:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGHVj-0001YY-Cq
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 21:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933253AbZFOTGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 15:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933880AbZFOTGR
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 15:06:17 -0400
Received: from terminus.zytor.com ([198.137.202.10]:41842 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764497AbZFOTGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 15:06:16 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n5FJ62vf007167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Jun 2009 12:06:02 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090615145716.GW16497@spearce.org>
X-Virus-Scanned: ClamAV 0.94.2/9467/Mon Jun 15 01:11:58 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121621>

Shawn O. Pearce wrote:
> 
> They could, if they were broken.  :-)
> 
> IIRC only upload-pack produces progress (from pack-objects).
> It does so by using a pipe on fd 2, and either copying it down
> to the client via side-band, or discarding it.  So progress data
> shouldn't ever appear on upload-pack's own fd 2, which means you
> won't get it in this syslog thing.
> 
> But I have to wonder, why are we doing this?  Why can't we teach the
> individual server program to record its error to the syslog before
> it aborts?  Are we looking for SIGSEGV or something?  Its only the
> daemon program staying around in memory, but that's a lot of little
> daemons doing nothing waiting for their children to terminate.
> Seems like a waste to me.
>  

Actually, even logging signals would be useful, so I think this makes
sense.  The daemon process is pretty trivial compared to the rest of the
stuff being spawned.

	-hpa
