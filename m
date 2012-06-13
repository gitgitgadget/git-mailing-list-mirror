From: Shawn Pearce <spearce@spearce.org>
Subject: git clone over HTTP returns 500 on invalid host name
Date: Wed, 13 Jun 2012 16:36:33 -0700
Message-ID: <CAJo=hJuax3-x53HJT-s32euyf2=d57MsRCQWo6NZO3OL35+o7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 01:37:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sex7R-00027J-OQ
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 01:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887Ab2FMXgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 19:36:54 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51673 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab2FMXgx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 19:36:53 -0400
Received: by dady13 with SMTP id y13so1721662dad.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 16:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=AoEK7IQd3E2fOAat8HoVdIZ8li/ErhYvR+itqHf2ASQ=;
        b=XDFkq3jwvQ/OQjxWvU8qh7aXBs0IkBBhV55on/7lXenIPHmi6G4KVPfqfo7rRsi2OP
         Z9WCUSsQCbweqK1f3pXw96mfrZSRF1kbewBDA4mB9qTmM0XcV96/aJK+9AZ+U/VAmMVe
         dEW+1PSfGCWZdmAYSGLWTfDNLFRd2lUnHDU6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :x-gm-message-state;
        bh=AoEK7IQd3E2fOAat8HoVdIZ8li/ErhYvR+itqHf2ASQ=;
        b=J2Ilx4Zm5iDNRC4rG2/rt55SRg5GcEVvGbf6JE3F/iEGcf0RluqRXIuN5cq/juFziG
         D+QKHGNCMLwb06ljrjMTZ7590wHDOG17wpPbVxJspQDLfaks8pcRZw4XzxKHyeLXmMA+
         wyPxf2sDMy6PNQHTBmchjgZd5oFDgLNO49xY4miL13DM0tf7Cy8jKky2ygCd32hCFFPz
         XpDnHPQvEa2ma0vqBxyLbxcesi+UhymIbkOW/hLQfAEJH925oIzteEgsHSXqv03lnFc8
         4CueQIJQq5KnTcntJ4gJHOmS1nMpFBVMLMLC8eBdiGt8Moqs+KzvVCQymw9U4Lf/q4nb
         hhqg==
Received: by 10.68.197.198 with SMTP id iw6mr1082493pbc.36.1339630613373; Wed,
 13 Jun 2012 16:36:53 -0700 (PDT)
Received: by 10.68.52.169 with HTTP; Wed, 13 Jun 2012 16:36:33 -0700 (PDT)
X-Gm-Message-State: ALoCoQk/Rjx44NiA61jvlbl/i8EzeHqRyaPxF11ZSOArtYnRMdqVstLEnZMIkSzcPknA3b2SE++x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199959>

$ git clone https://this.host.does.not.exist/foo
Cloning into 'foo'...
error: The requested URL returned error: 500 while accessing
http://this.host.does.not.exist/foo/info/refs
fatal: HTTP request failed


Hmm. Telling me the host doesn't exist is more useful than 500:

$ git clone git://this.host.does.not.exist/foo
Cloning into 'foo'...
fatal: Unable to look up this.host.does.not.exist (port 9418) (Name or
service not known)


Does anyone care about this other than me?  :-)
