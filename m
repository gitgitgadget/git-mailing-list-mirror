From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] Mark new entries skip-worktree appropriately
Date: Sat, 31 Jul 2010 13:13:32 +1000
Message-ID: <AANLkTikhXy1KjA5=SJ9ZwS_XtV99aHPkeo3XoPXqxeKh@mail.gmail.com>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
	<1280135310-2347-3-git-send-email-pclouds@gmail.com>
	<20100731023219.GB906@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 05:13:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of2W5-0000Pt-PA
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 05:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789Ab0GaDNg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 23:13:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50971 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab0GaDNf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jul 2010 23:13:35 -0400
Received: by wwj40 with SMTP id 40so2196082wwj.1
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 20:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zrFOQyaetsUfMdJVRmtJia1HjY3vbMre93VPm6zRHk4=;
        b=f2k0ZvUVSK65XRPm+XZTFmRMEVTltKZnXTUeqbm1WvcOkDkFLLx5ZFjeuwZIaP33aU
         ea0/AgsojHRF4PCClM/SA70y2h5VhWBLVHZj5YH+w8pMp69ijdUKDU5XzJ99eEGIrKXX
         PF35AemX2sTET4kheUeCWSLk/zKiwW5rduwB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qWOwYy1h9o+G1rqJXcMoS24CmFlgg8cjWdPEB0UIzl+M3ZhHSaJU02WfdjaZVsYudC
         h798zaDJktK8JwanAXGYRJOoBpGFOZ4sWKKicPm0TEqGLDhxUpC0BrAfkQlZCyRTorVo
         w5rKgqgObN6L4Ccf9zkPq4Rjc3MX6D8RJbeM8=
Received: by 10.216.185.72 with SMTP id t50mr2414677wem.77.1280546013353; Fri, 
	30 Jul 2010 20:13:33 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Fri, 30 Jul 2010 20:13:32 -0700 (PDT)
In-Reply-To: <20100731023219.GB906@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152294>

2010/7/31 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> Sparse checkout updates worktree based on the old and new
>> skip-worktree status when $GIT_DIR/info/sparse-checkout changes:
>>
>> old =3D ce_skip_worktree(ce); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // =
current skip-worktree
>> new =3D will_have_skip_work_tree(ce); =C2=A0 // from $GIT..sparse-ch=
eckout
>> if (old && !new) add_file_back(ce); =C2=A0 // shrink checkout area
>> if (!old && new) remove_file_out(ce); [1] // enlarge checkout area
>>
>> New entries after merging will always have skip-worktree unset
>> (i.e. old =3D 0). If those files are filtered out by
>> $GIT_DIR/info/sparse-checkout (i.e. new !=3D 0), then case [1] will
>> happen. But there is nothing to remove because they're new.
>
> When using unpack_trees to add a new file, there is no in-file
> index entry to grab the previous skip worktree bit from. =C2=A0If it
> is outside the checkout area, we should pretend it was skipped before=
,
> too; otherwise a checkout can cause a file on disk whose name
> coincides with a newly added outside-worktree file to be deleted.
>
> Do I understand correctly?

Yes.
--=20
Duy
