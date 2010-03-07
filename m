From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Add tests for git format-patch --to and format.to config
 option
Date: Sun, 07 Mar 2010 01:43:53 -0800
Message-ID: <4B937559.6000302@gmail.com>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org> <20100306003946.GD27414@genesis.frugalware.org> <7vr5nykx55.fsf@alter.siamese.dyndns.org> <4B92EDFA.1000602@gmail.com> <7vaaukdch2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 10:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoD1v-00038G-5v
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 10:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab0CGJoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 04:44:06 -0500
Received: from mail-iw0-f202.google.com ([209.85.223.202]:57332 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094Ab0CGJoC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 04:44:02 -0500
Received: by iwn40 with SMTP id 40so26574iwn.1
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 01:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Yz7ZPHrQtAlzazr38rTmfLy4PzN7JihHX+LDV2AbYis=;
        b=LBmtxc+5T7yNUfRwiju7vYGNfQVzAemOPzUO/8m3t46mkOdkTfihQ0sFkV/IyLoQpw
         vjII55YKHKrN6UODr0quMnGIVg5fxHC56qyZbTHzoh8Uuq3SDlE1vqZZNTJqNOZkVdiD
         jPWLOZcQo8a3zA6kukpFkOZcvgInrJcBLwuhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=dsiaov00G9xjPDl4U9UMEQV+4AU+BXNcJIp2n0i2nrh+n6heTQJkP1F/yc0v98wrZY
         s7NbyVRos8PKyGdGCpinT0cOxA2MD0eWChuxseJ++QFyZuNJEzbq8GUZjpUrLOo1UXQj
         F6RtqGS4dZ4YB5Lo742A4tUsdOM29rB6kaJVc=
Received: by 10.231.158.205 with SMTP id g13mr840572ibx.30.1267955041190;
        Sun, 07 Mar 2010 01:44:01 -0800 (PST)
Received: from [192.168.1.5] (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 23sm3415729iwn.2.2010.03.07.01.43.59
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 01:44:00 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <7vaaukdch2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141620>

On 03/06/2010 07:42 PM, Junio C Hamano wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
>
>   
>> The same applies to the fomat.headers and format.cc config options. How
>> is this different?
>>     
> Not different.  Perhaps we should fix them now you noticed they share the
> same problem?
>
>
> An obvious alternative is to keep format.to not get overriden by --to as
> the original patch did; that would at least make the handling between
> config and option consistent inside the command, but at the same time, it
> means format-patch behaves differently from everything else in git.
>   

Actually, I think the same applies to send-email too? There's
sendemail.to and sendemail.cc which can't be overridden. At least the
email associated commands are all quirky ;-)

Honestly though, I think you're right about fixing them. We have the
option of making them consistent with the rest of git with a little bit
of work. If you say --no-cc or --no-add-headers or --no-to the
respective config should be overriden. If you say --to or --cc or
--add-headers it should be appended. I doubt anyone would find that
surprising since --no-* doesn't do anything right now.
