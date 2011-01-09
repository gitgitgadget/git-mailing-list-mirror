From: James Cloos <cloos@jhcloos.com>
Subject: Re: git fails on large repo clone on intermittent, or intermittently-high-latency, connections
Date: Sun, 09 Jan 2011 15:04:55 -0500
Message-ID: <m38vyt7shs.fsf@jhcloos.com>
References: <AANLkTinkhmHpAQjraviKjqFAczThR5GtT_qdyf6Sb3nm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Zenaan Harkness <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Mon Jan 10 08:37:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcCJx-00019J-31
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 08:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852Ab1AJHhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 02:37:36 -0500
Received: from eagle.jhcloos.com ([207.210.242.212]:33673 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab1AJHhf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 02:37:35 -0500
X-Greylist: delayed 621 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jan 2011 02:37:35 EST
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 0F42940142; Mon, 10 Jan 2011 07:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1294644434;
	bh=Tvixhs47tIW8NJKzvYdmZleU6sZTzf3gHYYA1oyoNHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	b=AFqe6UrnDtw5KYLve0z+zO0SCrBU/IjrQUUI8xQUU4Q81nm9bw/1P/ZdVRxwGn81a
	 KlfX/N/9JkV9eFcJu/ifMUrQ+XsqZlXBvYNk+tlTgLZTCjw+5cjRzyqk7X0MYquiZF
	 J3pxLt3wXJHqUPcCMtSlK6vck3z+O00Qhz2PaeMc=
Received: from carbon (localhost [127.0.0.1])
	by carbon.jhcloos.org (Postfix) with ESMTP id BC5C6360011;
	Sun,  9 Jan 2011 20:04:55 +0000 (UTC)
In-Reply-To: <AANLkTinkhmHpAQjraviKjqFAczThR5GtT_qdyf6Sb3nm@mail.gmail.com>
	(Zenaan Harkness's message of "Thu, 6 Jan 2011 01:28:40 +1100")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/24.0.50 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:30:110110:zen@freedbms.net::ofk83gjciCLJu33+:9deGU
X-Hashcash: 1:30:110110:git@vger.kernel.org::UweM1ycu6zzlppqs:00000000000000000000000000000000000000000EYoxQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164868>

In addition to the other replies, if you have a shell login elswhere you
can clone there, bundle the file, and use rsync, http, ftp or the like
to copy it down.

If the remote site's git is too old to have git bundle, use a bare clone
and tar it.  You will not need to compress the tar.

You can also use split(1) to break up the bundle or tar into smaller
chunks if that helps.  cat(1) will happily recombine those chunks.

If git bundle was not available, you can use the copied bare repo as
a --reference for a new clone, then copy the bare's pack file into
that new clone and remove the new clone's objects/info/alternates file.

I've had to use that method to get a clean clone across a small straw
(dialup or wireless) for several large repositories over the years.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
