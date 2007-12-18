From: "Gerald Gutierrez" <ggmlfs@gmail.com>
Subject: RE: git with custom diff for commits
Date: Tue, 18 Dec 2007 12:35:28 -0800
Message-ID: <000001c841b5$89fcef00$762a14ac@na.acco.com>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com><Pine.LNX.4.64.0712172300510.9446@racer.site><vpq1w9kaphg.fsf@bauges.imag.fr><Pine.LNX.4.64.0712172310090.9446@racer.site><7vbq8o6gxw.fsf@gitster.siamese.dyndns.org><vpqk5ncz8fn.fsf@bauges.imag.fr> <7vodco1him.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
	<git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Matthieu Moy'" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:34:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4j9J-0006vS-8D
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 21:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbXLRUeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 15:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbXLRUeV
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 15:34:21 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:14537 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbXLRUeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 15:34:20 -0500
Received: by py-out-1112.google.com with SMTP id u77so4235917pyb.16
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 12:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:references:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        bh=zz8y1wDDsiB42zoUxMhCdkf+2yF2oXGHzocaGtAntNY=;
        b=Raw5Ffwjt5pEmICEK8q5V/s9RBy9feYkeN20aYcQBLUqEUfV2j0MLG4LTfW2fGtNcOczY4TVdqt35579W39r1kC+rwEcwlTcRi0pGGpf2TKYmtlgDr3iyPNfPjWhn/I/TBVB85Lm5y7KYWj/cJEobjq1L7OynWJzh9AWWYmDgRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:references:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=CTt/Iy9FB3A5NvHi/ZzR5JFObGSsC+fsWogkX/uNQqsZS10qs/P4nfETwJzG6vy5JGFBQD3sVaIvz4KM7HD/RVOGLDirupaaIHPW/uEYCYrFwfivu9i/LwJBGNL7DAE4ohuhF2NBMtpES4tl9Aglull8wtFl9NW4gVHgv6hsL58=
Received: by 10.35.82.16 with SMTP id j16mr877761pyl.57.1198010057073;
        Tue, 18 Dec 2007 12:34:17 -0800 (PST)
Received: from BURGXGUTIERNB ( [63.87.154.251])
        by mx.google.com with ESMTPS id w38sm22966355pyg.2007.12.18.12.34.14
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Dec 2007 12:34:16 -0800 (PST)
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <7vodco1him.fsf@gitster.siamese.dyndns.org>
Thread-Index: AchBV/zXbqGmotXQSqi8XEXBhSiIyAAXRDYg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68806>


> 
> So my updated suggestion would be:
> 
>  - Keep a checkout of that mysql dump;
> 
>  - Make the dump procedure to dump to that checkout area;
> 
>  - Run "git diff HEAD", perhaps with the external diff that 
> filters out
>    the cruft as suggested in the thread, and run "git checkout $path"
>    for paths that had only meaningless changes;
> 
>  - Run "git commit" if the above step did not nuke all changes.
> 

I ended up doing the following, which sounds similar to the above. Instead
of doing mysqldump into data.sql, it goes into data.sql.2 which I compare
with the checked in data.sql using "diff -I <timestamp RE>". If there are no
differences, I delete data.sql.2. If there are differences, I move
data.sql.2 into data.sql and check in. Perhaps not as elegant but certainly
works.

Gerald.
