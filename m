From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Mon, 2 Mar 2015 16:24:30 +0700
Message-ID: <20150302092430.GA30395@lanh>
References: <xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
 <CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
 <CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
 <xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
 <xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
 <CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
 <CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
 <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <xmqqioekawmb.fsf@gitster.dls.corp.google.com>
 <20150302092136.GA30278@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:24:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSMa8-00052K-5G
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 10:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbbCBJYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 04:24:03 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:43729 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbCBJYC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 04:24:02 -0500
Received: by pdjp10 with SMTP id p10so1021932pdj.10
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 01:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZGkkktEN7vjwbkHgq+h5gIpFsZHUxC21Xya/JjDhWmQ=;
        b=jWKpgz8ZNyzFP6dTOmFV9iraARCj7AOg25uIonvyIAvTpYdflmjhVkloTeGmQdPQ51
         H9q/CXR77+IsUYZig0VBEnAhxGZ+RwZvsvi06FTlLtOrbuQS5TMH4+G8HMM+4FXGiM+w
         KbPoDqALae78uUMr9s5EJ+5ZfDxwqsMSFpAAUFXy0MD3LX68DctaKNy95boCnQ48pTmB
         MkeEleI8auXHoscJnl9a7kyDi79Pq3oM+Xk+4GSjrdTnRGYGuqgD5ZQ+bdkKA8jypNJK
         kYUDK4VyQwHwVSRTwMEF85ziQfYOalt/LfcrCCOYrYi9H/te3+G6r/I4kHnX/bRaNQlr
         oCew==
X-Received: by 10.70.98.239 with SMTP id el15mr44888837pdb.133.1425288241490;
        Mon, 02 Mar 2015 01:24:01 -0800 (PST)
Received: from lanh ([115.73.224.188])
        by mx.google.com with ESMTPSA id ck2sm11247104pbc.80.2015.03.02.01.23.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2015 01:24:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 02 Mar 2015 16:24:30 +0700
Content-Disposition: inline
In-Reply-To: <20150302092136.GA30278@lanh>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264579>

On Mon, Mar 02, 2015 at 04:21:36PM +0700, Duy Nguyen wrote:
> On Sun, Mar 01, 2015 at 07:47:40PM -0800, Junio C Hamano wrote:
> > It seems, however, that our current thinking is that it is OK to do
> > the "allow new v1 clients to notice the availabilty of v2 servers,
> > so that they can talk v2 the next time" thing, so my preference is
> > to throw this "client first and let server notice" into "maybe
> > doable but not our first choice" bin, at least for now.
> 
> OK let's see if first choice like this could work. Very draft but it
> should give some idea how to make a prototype to test it out. Note
> that the server still speaks first in this proposal.

And ref discovery phase could be modified by new capabilities. For
example,

-- 8< --
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 56c11b4..56a8c2e 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -304,3 +304,36 @@ language code.
 
 The default language code is unspecified, even though it's usually
 English in ASCII encoding.
+
+compressed-refs
+---------------
+
+This is applicable to upload-pack-2 and receive-pack-2 only. The
+client expects ref list in reference discovery phase to be sent in
+compressed format:
+
+ - Each PKT-LINE may contain more than one ref
+ - SHA-1 is in binary encoding (i.e. 20 bytes instead of
+   40 bytes as hex string)
+ - ref name is prefix compressed, see index-format.txt version 4.
+ - Ref list ends with flush-pkt
+
+glob-refs
+---------
+
+This is applicable to upload-pack-2 and receive-pack-2 only. In
+reference discovery phase, a new mode "glob" is supported. Where the
+arguments are wildmatch patterns. Negative patterns begin with '!'.
+Only refs matching requested patterns are sent to the client.
+
+stateful-refs
+-------------
+
+This is applicable to upload-pack-2 and receive-pack-2 only. In
+reference discovery phase, a new mode "stateful" is supported. Where
+the first argument is a string representing the ref list that was sent
+by the same server last time. The remaining arguments are glob.
+
+The first ref line that the server sends should carry a new state
+string after ref name. The server may send only updated refs it if
+understands the state string sent by the client. Still under discussion.
-- 8< --
