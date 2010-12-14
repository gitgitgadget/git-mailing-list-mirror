From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 09/19] tree-diff.c: reserve space in "base" for pathname concatenation
Date: Tue, 14 Dec 2010 20:01:21 +0700
Message-ID: <AANLkTikXvx7-Q8B_dqG5mMHGK_Rw-dFaeQdXi0zW98SD@mail.gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-10-git-send-email-pclouds@gmail.com> <7vlj3t35ol.fsf@alter.siamese.dyndns.org>
 <AANLkTi=5QgkBd434=Z7MCA_ZNZCXVyXJYh_fd1A+B2ue@mail.gmail.com>
 <7vvd2wvs0m.fsf@alter.siamese.dyndns.org> <4D071DAA.3070400@viscovery.net>
 <AANLkTimzmq8gUpXUZ801Q+pua_mZMHTJ6wYt_CwcTr3v@mail.gmail.com> <4D0728F0.9020807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 14 14:02:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSUVz-0007rr-9V
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 14:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759241Ab0LNNBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 08:01:53 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40636 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759168Ab0LNNBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 08:01:52 -0500
Received: by wwa36 with SMTP id 36so473559wwa.1
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 05:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=W7kzDP3SyNOTiekERvDV6drSIM6+Gx1A8z+NvFjYXAA=;
        b=PvMK9xamJx8Jcvo5vy+gtPvzzXwbIlYwCeLK7C7zfX4Q878PiMKVt+Jj4GGQmCu2Kl
         f7VMJmTFLFUvWtNFQrESjLOHdMq98D7T6pxewjIvgwCiEiqW8ZKD6bwFWrRKjjX8dXCr
         FwKNJS8HVwtTZUqpcfKYLRJy2RLKV6my/TTrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kUnT7sU7snFGXWgZ4MoMRIPkHRK6ViUaZBKvm+Iz54g6HMi2iszIrPvaY+stMQ5nft
         yVmiI5X3GlSvk2DB7doypR3ocZmsni88QKGYgC05HZuBN7ZMuc4sWZhu7RI/zpBAqjjB
         H+7svnk6e4ZymPH7a75UqGUy2dsCQXkbj5600=
Received: by 10.216.162.70 with SMTP id x48mr4748189wek.4.1292331711132; Tue,
 14 Dec 2010 05:01:51 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 14 Dec 2010 05:01:21 -0800 (PST)
In-Reply-To: <4D0728F0.9020807@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163646>

On Tue, Dec 14, 2010 at 3:21 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 12/14/2010 8:43, schrieb Nguyen Thai Ngoc Duy:
>> On Tue, Dec 14, 2010 at 2:32 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Am 12/14/2010 6:32, schrieb Junio C Hamano:
>>>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>>>
>>>>> All paths should not exceed PATH_MAX, right?
>>>>
>>>> Your PATH_MAX may be a lot shorter than the PATH_MAX on the system I
>>>> created my trees on that you are reading.
>>>
>>> And that is not just gray theory: On Windows, PATH_MAX is whopping 260
>>> characters!
>>
>> Does that mean Windows won't accept any path longer than that, or
>> PATH_MAX is defined just for fun?
>
> It is the limit for path names that we can have without MAJOR extra
> efforts. It is not a limit implied by the file system.

Just googled around and found this [1]. I'm going with strbuf so it
can be reallocated if necessary. A bit tricky because "base" can be
moved, but I think it's worth it.

[1] http://insanecoding.blogspot.com/2007/11/pathmax-simply-isnt.html
-- 
Duy
