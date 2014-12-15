From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: remote helper example with push/fetch capabilities
Date: Mon, 15 Dec 2014 13:44:59 -0800
Message-ID: <20141215214459.GJ29365@google.com>
References: <CAPCWLt6kxoJJSWAcyH_kW071Md0vc4zeo41hCKBQHd-_pvUMXQ@mail.gmail.com>
 <20141215204740.GI29365@google.com>
 <CAPCWLt4=oYTPFXktCj8CgqNncaO2=sbwZcPOVa+a5wgt7HPCUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Klein W <wineklein@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 22:45:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0dS3-0003Lt-1K
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 22:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbaLOVpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 16:45:04 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:58897 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaLOVpD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 16:45:03 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so11164977iec.8
        for <git@vger.kernel.org>; Mon, 15 Dec 2014 13:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=atP2w33T4+zFGAMzSsd98EnDQeby9gPijZ1S32c/Vxo=;
        b=uLe6D6lCVZtRAhDE70NNZe8BJ/Qvr5sL9AAgO0Nakte8c31qRLcyRJUH3eoklFBRaZ
         +hZ+De/kbTceKC6j3j5QYK7SyTys30YECHgdvJeOcWhcbL3vqmSCNAl/Ryhtvo9QYR8J
         b5IgAl9qZ5JWwP9yNTZKu1sDNvdTPsY0ajL1kYVgumpnGhPqzPw8eoRDmqSO9XdVwsss
         XLzUruVcdJHOOW7xeB9sFLnBKVCvFvozYDu9D804VemXAYqiF+x6ruw+Oue6kdfQYw/D
         igVmgShbXLdJPB803YA6vljLZWZANGdCF75TqSdAl4ovWbNchb9RCeN3l9SaP5fE8OcG
         zd5A==
X-Received: by 10.107.38.202 with SMTP id m193mr30905287iom.19.1418679902068;
        Mon, 15 Dec 2014 13:45:02 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:216c:de00:a6aa:1f46])
        by mx.google.com with ESMTPSA id f9sm5264189iod.24.2014.12.15.13.45.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Dec 2014 13:45:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPCWLt4=oYTPFXktCj8CgqNncaO2=sbwZcPOVa+a5wgt7HPCUQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261426>

Klein W wrote:
> On Mon, Dec 15, 2014 at 3:47 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> It mainly has to do with what it is convenient for your helper to
>> produce.  If the helper would find it more convenient to write native
>> git objects (for example because the remote server speaks a
>> git-specific protocol, as in the case of remote-curl.c) then the
>> "fetch" capability will be more convenient.  If the helper wants to
>> make a batch of new objects then a fast-import stream can be a
>> convenient way to do this and the "import" capability takes care of
>> running fast-import to take care of that.
>
> I'm trying to write a remote helper for hosting git remotes on Amazon
> S3.  Do you have any intuition about which capabilities would work
> best for this case?

fetch/push.  I'd suggest looking at the "dumb" HTTP code (fetch_dumb,
push_dav) in remote-curl.c to start.

Thanks,
Jonathan
