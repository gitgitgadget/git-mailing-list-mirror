From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Mon, 20 Feb 2012 21:16:43 +0700
Message-ID: <CACsJy8AHEHDAa2v4DvNgwd1YsBQuRCL9bHaxF70L8O4yWc4gZg@mail.gmail.com>
References: <8762f9k5sg.fsf@thomas.inf.ethz.ch> <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
 <20120215190318.GA5992@sigill.intra.peff.net> <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net> <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net> <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net> <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 15:17:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzU3M-00025I-1y
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 15:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519Ab2BTORP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 09:17:15 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:61631 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab2BTORO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2012 09:17:14 -0500
Received: by werb13 with SMTP id b13so3188376wer.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 06:17:13 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.74.177 as permitted sender) client-ip=10.180.74.177;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.74.177 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.74.177])
        by 10.180.74.177 with SMTP id u17mr17681085wiv.13.1329747433362 (num_hops = 1);
        Mon, 20 Feb 2012 06:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8jYxfopwUC6jUCnwbVmMGlMqILPVTVQjq32G/hVSyw4=;
        b=uOpePl03GN1T1LufOc+9JOjI2u1CfoETJJxw+bZbIcYNF6vheMVmL5eZSwHjDQ1oIo
         6CNgeyokNTEUpmOePZhyoAcpkEt5H6/yObdFEqdNqi2PxWqIDhxPVSHL+8gf9W3KW5rw
         i0sjz1sW90ojulXNxzK8xnYLS4fO5lEdlbkEM=
Received: by 10.180.74.177 with SMTP id u17mr14674663wiv.13.1329747433290;
 Mon, 20 Feb 2012 06:17:13 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Mon, 20 Feb 2012 06:16:43 -0800 (PST)
In-Reply-To: <20120220140653.GC5131@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191072>

On Mon, Feb 20, 2012 at 9:06 PM, Jeff King <peff@peff.net> wrote:
> Interestingly, on my git.git repo, I had an empty cache. Running "git
> read-tree HEAD" filled it (according to test-dump-cache-tree). It see=
ms
> that running "git checkout" empties the cache. =C2=A0So perhaps git c=
ould do
> better about keeping the cache valid over time.

=46or fast forward case when result index matches 100% destination tree=
,
yeah we should repopulate cache-tree. "git reset" does that. Not sure
about other cases though. I don't think we can keep track what
subtrees are unchanged after unpack_trees() in order to keep them.
--=20
Duy
