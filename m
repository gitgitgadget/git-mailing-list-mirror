From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git-send-email generates mail with invalid Message-Id
Date: Tue, 28 Jul 2009 11:17:10 +0200
Message-ID: <40aa078e0907280217g76cbfai8544edde605f8772@mail.gmail.com>
References: <200907280446.22890.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Tue Jul 28 11:17:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVioC-0003MX-PD
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 11:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbZG1JRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 05:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbZG1JRN
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 05:17:13 -0400
Received: from mail-bw0-f221.google.com ([209.85.218.221]:63740 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbZG1JRM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 05:17:12 -0400
Received: by bwz21 with SMTP id 21so762504bwz.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=p96vfCJos9lCt4VQ6UhblXKrrEdDd/Ig2gPcS8Y6CJA=;
        b=Oygc4NYHORpgnC/idnGbEURJP2ghPkbrQLjSGN5lCSH2jbCWZkxdvYo0TA6GzYo5JL
         aJPYgVxJuTSgioKZyQBdOTj5QMcZAfxA88xwTWSAiy0wHX11zp7vcsEWKK/j1McOnL83
         bhVe491XAWsioc81+g+l+XQpGyECN8IcjpMV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rySLA62qSpcUbhu6RzqTuB/TuwenLWRWFFpynSBDZVXDgAkrpQvrPDklAINamVbfzt
         S9Zgb1XWt74sI1Q+q8edXazFsqI1t9QtJOH5NdOuXe9s8e6nMHtwLf9XEjGPXegIcJi5
         9Jol5a/rp3PVb+jwym9CeXfLwbJk/hfnKw89c=
Received: by 10.204.54.4 with SMTP id o4mr4092961bkg.208.1248772630046; Tue, 
	28 Jul 2009 02:17:10 -0700 (PDT)
In-Reply-To: <200907280446.22890.elendil@planet.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124226>

On Tue, Jul 28, 2009 at 4:46 AM, Frans Pop<elendil@planet.nl> wrote:
> The problem is that a Message-Id is supposed (RFC 822) to end in a domain
> part (...@example.com), but that's missing.

Correct.

> I assume that this is a configuration issue in the git setup of the
> sender, but shouldn't git-send-email refuse to send out messages with an
> invalid Message-Id?

Not quite. git-send-email generates these message-ids itself (those
who contain "-git-send-email-", that is), and should as such be able
to rely on them being generated correctly. However, I'm a bit curious
as to how these ends up incorrect in the first place. The code in
make_message_id tries to append the sender's e-mail to
timestamp+"-git-send-email-", if that fails it tries the comitter's
e-mail, then the author's e-mail. As a last resort, it tries to append
"user@"+hostname.

I'm no perl-expert, but the code looks pretty much correct to me.

The problematic e-mails, are they coming from another user than you?
Can you find out who that is, and check what git-version he or she
runs?

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
