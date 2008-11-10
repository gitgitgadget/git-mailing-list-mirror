From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: multiple-commit cherry-pick?
Date: Mon, 10 Nov 2008 21:24:22 +0100
Message-ID: <81b0412b0811101224gcffc958o6dbfcdc45e022874@mail.gmail.com>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>
	 <20081106213711.GA4334@blimp.localdomain>
	 <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org>
	 <7vskq4gmf5.fsf@gitster.siamese.dyndns.org>
	 <20081107071231.GA4063@blimp.localdomain>
	 <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org>
	 <20081109102528.GA5463@blimp.localdomain>
	 <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Miles Bader" <miles@gnu.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:25:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzdKM-0004EH-EP
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYKJUYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 15:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbYKJUYY
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:24:24 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:47086 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbYKJUYX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:24:23 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2685071rvb.1
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4akNYnuFaglrySI+piw+RUNhIhcM0+NvitS+SQSQz8Y=;
        b=D3p5WdXx44Mihte/Cgxsutx2tZJB0WbyqbjHQc/dM2QlOBg/p/Bg+XGWunG9UKQFvB
         vPjR+S8KYYF2RjSkDc5X8CoqEASPmWOvy0IxRzqY7Fu0uXWQCxAFfCgPSCQd8lfD1FAR
         OmyUhkSFATmTY/KE8Hk2fK7Mgg+4hDHzsQRTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UmGn3gcLh+Hm1Bjcp2cboUlVv2Bxr8vpoaX7oYw6J2avExHNwzSgxsnmcnXhZ9qm5T
         ykKhKtb71QvIFEs+oQSBfV6Ujnh2SGSGGGDK0X+pkL+fOnCUUNj89nqtGDvf3DZ6gAgp
         /fjgU5T1kQHTnysWYlmZjdQETIjHD1ErtlBnU=
Received: by 10.115.46.10 with SMTP id y10mr4591751waj.182.1226348662395;
        Mon, 10 Nov 2008 12:24:22 -0800 (PST)
Received: by 10.114.157.9 with HTTP; Mon, 10 Nov 2008 12:24:22 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100559>

2008/11/10 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Sun, 9 Nov 2008, Alex Riesen wrote:
>>
>> Oh, I am. But it is just so convenient to have range support for
>> commands which just show commits. Besides, git-show just errors out,
>> instead of producing the commits like git-log does.
>
> Have fun implementing the support, and then explaining to users why this
> shows only one commit:
>
>        git show HEAD^..HEAD HEAD~10
>

for cs in HEAD^..HEAD HEAD~10; do
  case "$cs"; in
  *..*)
     git format-patch --stdout "$cs"
     ;;
  *)
     git show --pretty=email "$cs"
     ;;
  esac
done

At least, this is what I have in mind and how I expect it to work.
