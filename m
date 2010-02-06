From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] rebase: add -x option to record original commit name
Date: Fri, 5 Feb 2010 20:58:09 -0500
Message-ID: <76718491002051758s577d8b5eq2323cd66d479662@mail.gmail.com>
References: <1265419166-21388-1-git-send-email-jaysoffian@gmail.com>
	 <7vzl3ngn7w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 02:58:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdZwB-0007EW-1n
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 02:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933821Ab0BFB6M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 20:58:12 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:44525 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933133Ab0BFB6K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 20:58:10 -0500
Received: by iwn15 with SMTP id 15so1693161iwn.19
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 17:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RH0ea6jC4TXYBpm57gyfTnnBht/Y6TX+wQCDiRjLvDg=;
        b=GpzJ7OMtkLjN0YSkhvGoNBf/HLHZweLi/aOLzn65/W73Qko70g5QeQrQau/Gr+Q14h
         L47Za6cogRmUkGJk3WpkRRsRZLrq9sRC77VkStSAKKhskPOaaHD+tixaqvD4/EzdYyUN
         /MYYGc5FO/NDDn7anz0OTWs9hJukafX9KckiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mYml9TGRMZULcHjjVgcCdjf8lNyHsCHx1X3APTM2ulUFywnGmuJdGyzivxjoMJbXJg
         kBIcHvz3/20XSZMf5bR4CF0rCMTLm+Kqx4AyuvbRGy6+8czUuPNZu2l0LvnxzKPO2dWp
         +nLKZLk7jEhzMrqr9iezTbey87/ag3hv095fk=
Received: by 10.231.149.201 with SMTP id u9mr1110522ibv.1.1265421489139; Fri, 
	05 Feb 2010 17:58:09 -0800 (PST)
In-Reply-To: <7vzl3ngn7w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139137>

On Fri, Feb 5, 2010 at 8:35 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> In the longer term, we would rather deprecate -x from cherry-pick, so=
 that
> we won't contaminate the commit log message.

Well now that's interesting. I am in the process of back porting a
large amount of development, and it seems very useful to record this
information in the log message. The subject messages are not always
unique, so it's provides a very easy to find the original commit.

I know you can use "git cherry" to look for identical commits, but I'm
actually adding the "(cherry picked from ...)" especially for when the
new commit is not identical, so that I can then easily emit
interdiffs. I want to make sure that the backported work is as true to
the original branch as possible, and it's much easier to compare
commit by commit than the end product.

>=C2=A0So in that sense, I would give a mildly negative response to thi=
s patch.
>
> We might instead want to add a hook that is called from cherry-pick (=
and
> rebase will get a similar one) immediately after the command creates =
a new
> commit out of another commit, so that people can record the correspon=
dence
> in notes namespace if they choose to.

Hmfph. So I know some folks don't like polluting log messages (e.g.,
the git-svn-id footer, or apparently, the cherry-pick -x message), but
I actually prefer having this data embedded there than hidden in
notes.

j.
