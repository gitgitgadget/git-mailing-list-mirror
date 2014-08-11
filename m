From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 01/22] refs.c: create a public function for is_refname_available
Date: Mon, 11 Aug 2014 08:00:58 -0700
Message-ID: <CAL=YDWn=DWBbL24H2Ka5+1yXJ813aokyyfJrBDkFtvVTNO4EbQ@mail.gmail.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
	<1407516309-27989-2-git-send-email-sahlberg@google.com>
	<1407518873.26542.20.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 17:01:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGr5t-00039w-CB
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 17:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbaHKPBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 11:01:00 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:38490 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbaHKPA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 11:00:59 -0400
Received: by mail-vc0-f169.google.com with SMTP id le20so11858127vcb.28
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vmXJtQw+kuiD1U9uSOC3f8Cm/VO5knGeeB+dFhGURZM=;
        b=mZhvxrEnmMKNy4XtYBuLJN3L/WTWAuCcBFdkkrEtLGvBRWSOCUuGn4ufbQufFWpIcI
         hBCuN0Ym+wQvmKp5su7osduJIb/4W1IwvcrmAXrWrFTW50xSFL0i8FM1iHBuVo/mEwhA
         kQghEuQvj+Z1nXhJ6DnevNEDT4Us0s+a5lDq/EOMDUJlGv9QZsf2ibxNGpLLNSvgAD+I
         1QXKy5NRBoY3QwNVz3CdgQlPLZSJoxyLiQWyPXsaFkm0EBBJulihUnBAl8nA2+XwFtMf
         rbWf63GMjkhgvhJZuacI79RGjo5eloFL2qB/tNa5GSzLLL/g2XWSfEqeziO3vhHbdwiq
         1U5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vmXJtQw+kuiD1U9uSOC3f8Cm/VO5knGeeB+dFhGURZM=;
        b=kJgDZAEoIJrS/zgCrdYIztzKfh2apb2cuqn/1FxVbSoWNPXI5GO28GOHPMikHHQSXE
         37RxsQZbz0984xtaX0AswgQlkajtMAxgULSqtjs2545AqhUIMO4QVXRsSDanxTBmj0m/
         zZ1XK/kQ89S3LFSZXnlF3oqUFazs801y1rUV5uxXEt5lHSDmS5tAT+EX/iKGVVhShnjn
         2JNYNh4+h9mtHXZL5W8nX4W2hdmH8SsCEBs2IoYAPDIAdQz9gKMH2nIb9CZzQNeJcrX4
         5K2V4jk6/NPNzCHT6hJu4S0dsIrrkR67Ya24/1P4GPVJGjh1MatvKTZs2StL3pOeOGpT
         I+CQ==
X-Gm-Message-State: ALoCoQlzlJwQ4VrfBYyzmICZyLyw5jD24zffRA7JFi34yYhL7WSp68TEgozMywZXDuczM+81c9ma
X-Received: by 10.220.160.67 with SMTP id m3mr722925vcx.56.1407769258897; Mon,
 11 Aug 2014 08:00:58 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Mon, 11 Aug 2014 08:00:58 -0700 (PDT)
In-Reply-To: <1407518873.26542.20.camel@leckie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255125>

Fixed. Thanks!


On Fri, Aug 8, 2014 at 10:27 AM, David Turner <dturner@twopensource.com> wrote:
> On Fri, 2014-08-08 at 09:44 -0700, Ronnie Sahlberg wrote:
>> + * Check is a particular refname is available for creation. skip
>> contains
>
> s/Check is/Check that/'
>
>> + * a list of refnames to exclude from the refname collission tests.
>
> "collision"
>
>> + */
>> +int is_refname_available(const char *refname, const char **skip, int
>> skipnum);
>> +
>> +/*
>
>
