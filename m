From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: large files and low memory
Date: Tue, 5 Oct 2010 17:13:35 +0700
Message-ID: <AANLkTimHKyQhAzuh4Hsh7=bEet1T0mNRSMgiZkhWQwSN@mail.gmail.com>
References: <20101004092046.GA4382@nibiru.local> <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <4CAA1BEB.3050908@workspacewhiz.com> <AANLkTi=nzyRgiBL07f2oeyjdUc8XnaKbJEJ+k8_g9rQ1@mail.gmail.com>
 <20101005005902.GC2768@nibiru.local> <20101005074144.GA22564@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 12:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P34XI-0000Hc-Df
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 12:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813Ab0JEKOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 06:14:10 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:34596 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932761Ab0JEKOI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 06:14:08 -0400
Received: by wwe15 with SMTP id 15so32413wwe.1
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 03:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=fu+pQdnifbwngvvyapb1F7sm1QetfiBkJ31Yuw3VNHI=;
        b=P/kZ7qSYzVopGCthkV0I+UhMXexDtQExdV2c0Fl+C0InKuyAd8ujxYa+6XkiHWfPpL
         GBgySM8wpA4u/Jv3yPeoeZE7CIK0HFBt1+E5gGZYztxX+aE371nCHtKJVoKuz2vjCvkY
         SIKwDSo0t9VRJ5nyhEX90n8mVcCC/mKa2cTYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=feuk0WprXgAxLuarIXqjpvOsVnZc0P6lLGm6/xhOLA106ETiGLyexA4ym2m4wJnspP
         Sht1/ViuqcPoBcOk09ltKBGPseAzqOQcltBdABnOOL0f9aMbCVHSs0bhzACHFbJGQix+
         ks5rUwBe4EZxsta/tYkkbJWdXzgGEiF2oxxKs=
Received: by 10.216.91.16 with SMTP id g16mr8930809wef.78.1286273636203; Tue,
 05 Oct 2010 03:13:56 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Tue, 5 Oct 2010 03:13:35 -0700 (PDT)
In-Reply-To: <20101005074144.GA22564@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158183>

On Tue, Oct 5, 2010 at 2:41 PM, Enrico Weigelt <weigelt@metux.de> wrote:
> * Enrico Weigelt <weigelt@metux.de> wrote:
>
> <snip>
>
> Found another possible bottleneck: git-commit seems to scan through
> a lot of files. Shouldnt it just create a commit object from the
> current index and update the head ?

You mean a lot of stat()? There is no way to avoid that unless you set
assume-unchanged bits. Or you could use
write-tree/commit-tree/update-ref directly.
-- 
Duy
