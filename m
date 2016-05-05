From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] submodule deinit: require '--all' instead of '.' for
 all submodules
Date: Thu, 5 May 2016 13:54:41 -0700
Message-ID: <CAPc5daU5xLP9XghK=FfpubF96a-t+gqbg4YCBDdWc35Og8EUZA@mail.gmail.com>
References: <1462477952-6669-1-git-send-email-sbeller@google.com> <20160505203705.GB22726@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:55:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayQIk-0004H5-HR
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 22:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756526AbcEEUzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 16:55:03 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34824 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906AbcEEUzC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 16:55:02 -0400
Received: by mail-yw0-f172.google.com with SMTP id g133so143931966ywb.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=M1jS9FWHCuBJQTdGGLTKTKJx2F/6Xlvdz9rPGelKG/o=;
        b=uIMOPhleP2Cbd0rubLeiqzwurSdTjaoO26WQsoKu2aNh3BrgasOw4OkEqXcGSs4L4F
         huRfHvmuxGQycffbabJV0/m2JGEZhs/IdRk8maIXOOS28JuRNG4i7JEflzqFpt8stgHM
         zR/NOQvDrGx5B17vILUdryLJ1IaQG/zTBpXZZxwMi8wrzvOU7UXB4qg8jywzgQuReyo5
         yNSATX3Rq1mR0ubZpVHYNxwm3gjSVz2V26dNsjVTvepoJRS8uEaIYYk6L//eAFc3vpnX
         gpjWyo3FvBR7YaAaHIKywuNV9+UxKveXePL6dSmY3z+2XGbzqNpvhMhr03DZeeL4iDLh
         qsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=M1jS9FWHCuBJQTdGGLTKTKJx2F/6Xlvdz9rPGelKG/o=;
        b=USPC2HTjpZQZvfu2SfAUI1MEozgMNSPSKUPaVHgbiBcnFfzFCRT4FurgLBTSkJ7hcZ
         P29zoBF2jZ6ZQ1192GiDnx+d9vblz2hoJk//TJIHkQ2/ppnOPgZu+6srhHi4GFyhjSX4
         igwbc1zRiafBNfQ70TlCjRTnpow3cpK6ErB7FFKpMxVANkma+7JQxIbwsNXmH76Bq2mr
         7Vac/iwwbccO2bTVgoijmMvdu301ctFTnNU1zw7AGHLOkJCoPLv7T3+pefvxhq8G4ZNj
         YiF8SHki0J7a+dq6yWFPSKv3iV+zemK8BDPghIvXK0AAft5yGCZwZ47sGOQPggzj3s3D
         LdVw==
X-Gm-Message-State: AOPr4FWjwC/ax97nbd9F2bbiUtf/uceRRjW40zhgcNUdIjI5uTpddRzJGPgvxvitSwVbCSASLXfFyjDC2o6q2w==
X-Received: by 10.129.161.72 with SMTP id y69mr9446626ywg.191.1462481700524;
 Thu, 05 May 2016 13:55:00 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Thu, 5 May 2016 13:54:41 -0700 (PDT)
In-Reply-To: <20160505203705.GB22726@google.com>
X-Google-Sender-Auth: OPdRp4FccWKVTDbbVUX5K_a0cqY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293679>

On Thu, May 5, 2016 at 1:37 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>>>        $ rungit v2.6.6 submodule deinit .
>>>        error: pathspec '.' did not match any file(s) known to git.
>>>        Did you forget to 'git add'?
> [...]
>> So instead of a pathspec add the '--all' option to deinit all submodules
>> and add a test to check for the corner case of an empty repository.
> [...]
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, both. Will queue.
