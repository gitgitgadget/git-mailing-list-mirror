From: Tim Webster <tdwebste@gmail.com>
Subject: performance issue: git clone compression
Date: Sat, 7 Nov 2009 17:09:59 -0800
Message-ID: <72877ab10911071709s200696d4mf12dc797da20be18@mail.gmail.com>
References: <72877ab10911071657p568b3b98v6fd90e84e098c107@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 02:10:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6wIg-0003XJ-7l
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 02:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbZKHBKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Nov 2009 20:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbZKHBKP
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 20:10:15 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:33320 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbZKHBKO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Nov 2009 20:10:14 -0500
Received: by qw-out-2122.google.com with SMTP id 3so408569qwe.37
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 17:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=utjhqCQcF+SZdvgdrfKOqc6QDqdscUKjiVXs+EQat+U=;
        b=wwENVAa1tr23zHWDRgRoi6kycIFWp+AHpOTNr/b5eHi9TAjom/yk6lsTA3pDMtf8I/
         YhVqxU3LDwWF11wzCQ3MCRiMrK5Wtdgl1YnIaMVH77rmLP4E3Eyo2RotiWZFWZpm2fdC
         XDm7N8aEj5IWr55UV/MfTS0xwnYentXH3Rptc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=GNSiK4ocdYK2WTlC2Q5GKLCnz4r2p6jxvN/+laxQG+uUTdUKAo+E3j/ae/qXzMfYu+
         lV69dw2iCot3j7a3HLr3SP9ifZ0hfyajcQOsRmu1Zws4BbhGfQCPcOl6Vy7f/oR90jrD
         ftG7eE0ySv8Ph+1FQzXcdlZs+9ZkjZtEedVaI=
Received: by 10.229.41.75 with SMTP id n11mr330270qce.56.1257642619056; Sat, 
	07 Nov 2009 17:10:19 -0800 (PST)
In-Reply-To: <72877ab10911071657p568b3b98v6fd90e84e098c107@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132382>

git clone gitosis@gitserver:code.git

After remote counting objects, remote compressing objects
transfer begins...
This compression operation results in excess of swapage on the remote s=
erver.

--------------------

I need to avoiding the clone compression step for servers with limited =
memory.
I am doing the following to avoid this object compression. Is there a
better way?
-------------------

scp -r gitserver:/srv/gitosis/repositories/code.git=A0 .
git clone /tmp/junk/code.git --no-hardlinks code
# IS there a better way of converting the bare git repository to
working git repository?

edit .git/config
url =3D gitosis@gitserver:code.git
