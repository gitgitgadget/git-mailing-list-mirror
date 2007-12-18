From: "Gerald Gutierrez" <ggmlfs@gmail.com>
Subject: RE: git with custom diff for commits
Date: Tue, 18 Dec 2007 14:27:38 -0800
Message-ID: <000d01c841c5$386f7350$762a14ac@na.acco.com>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com><Pine.LNX.4.64.0712172300510.9446@racer.site><vpq1w9kaphg.fsf@bauges.imag.fr><Pine.LNX.4.64.0712172310090.9446@racer.site><7vbq8o6gxw.fsf@gitster.siamese.dyndns.org><vpqk5ncz8fn.fsf@bauges.imag.fr><7vodco1him.fsf@gitster.siamese.dyndns.org><000001c841b5$89fcef00$762a14ac@na.acco.com><7vzlw7ybx7.fsf@gitster.siamese.dyndns.org><000101c841b7$5f1d1060$762a14ac@na.acco.com> <vpqsl1zfz8r.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
	<git@vger.kernel.org>
To: "'Matthieu Moy'" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:27:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ktx-0004Vk-O2
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 23:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbXLRW0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 17:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbXLRW0i
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 17:26:38 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:39452 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbXLRW0h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 17:26:37 -0500
Received: by py-out-1112.google.com with SMTP id u77so4314971pyb.16
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 14:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:references:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        bh=ZPdp4rU64wPZ25NUov69IJil78gP9JaOUsgM49DPSHM=;
        b=HjMxYQmSBH7TzKTUCAJILHLmH6mOlKw2N5NhAmvrM8HaPXhgXSe+j3jzzk5d6BUCsqRtv40L5kh1hK9kS1C5lKsf3QtcTdEqe04w30ERRocaNgcopljzSO/vmQ+eiCxVYgG5g4dEmI4BIMNVOqNs3BGOex4Fk1srtQckEGMFM7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:references:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=MGQ1ZCe4oNWEKuLAmNR0vvL/49nZq/8D5gE3K7RZIXrG+x/cbc1wrZwGKGAGgdZcXvh2jjhW3R4wUaJCkCGRmvTvQRNESojRRFdmeIQck6J7wuosbi6+wpskA/puBOvuRrv2nyGphGUiFQgG/gL+xrBYWPbMWi3ICNfhMFNzmd0=
Received: by 10.35.101.1 with SMTP id d1mr1710958pym.51.1198016796168;
        Tue, 18 Dec 2007 14:26:36 -0800 (PST)
Received: from BURGXGUTIERNB ( [63.87.154.251])
        by mx.google.com with ESMTPS id u2sm14169402pyb.2007.12.18.14.26.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Dec 2007 14:26:32 -0800 (PST)
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <vpqsl1zfz8r.fsf@bauges.imag.fr>
Thread-Index: AchBwDUSR6tc9ZbMTe2tF1KKsV9vhQAAs5Ng
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68834>

 
> What you seem to expect is to tell git "commit the changes 
> except this portion", what you have to tell git is actually 
> "commit the new state, but not if this portion is the only 
> change". That sounds identical, but it's actually a bit different.

It's not what I'm saying.

Here's what the git-commit manpage on kernel.org says: "git-commit - Record
changes to the repository".

What I am saying is that if the user defines a custom diff, it is reasonable
to believe that the user wants to teach git a new definition of "changes".
If that new definition says that the files have changed, then go ahead and
commit the new state. If that definition says there are no changes, then
there is nothing to commit. In other words:

if (user_redefined_changed)
  if (user_defn_of_changed(work, head)) commit(work);
else
  if (builtin_changed(work, head)) commit(work);

As it is, it's not a big deal to me. Instead of teaching git the different
concept of "changes", I teach the script that runs git instead. But teaching
git directly just seems cleaner and more intuitive.

Gerald.
