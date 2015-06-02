From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFCv2 10/16] transport: connect_setup appends protocol version number
Date: Tue, 2 Jun 2015 15:09:23 -0700
Message-ID: <CAGZ79kbnX_kyuvj73PGcO7OBOj7CfdouARrqNWEkCnUfdN=DqQ@mail.gmail.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-11-git-send-email-sbeller@google.com>
	<xmqq8uc123n5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 00:09:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzuNH-0001Ii-LO
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 00:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbbFBWJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 18:09:27 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33381 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbbFBWJY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 18:09:24 -0400
Received: by qgfa63 with SMTP id a63so65019297qgf.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 15:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=C7jgHzHXrYhVO8nedhokWYsBV6IWdxzi5+EECVbrq4I=;
        b=nNhz18nFfE0Dyt4z0qCDmGFz2tOFx+rPDBPU+8pPQl6kizHrFrdAWSdZW+zvqscHrs
         LLvWDTRdyvPGk6atfd9hP88a0VIN/KMJmkiuy3ufop3oh4p6exk820YLLFQXOrV4SH7r
         hGzfM9MlrD2mnq86M8kKc5tu2PAhhYhRZO406kcsFmsPauqPV/Aw/b+eenXZ+CkuskeI
         OUoWDSexO29rjoOjEz426oNindLX5uIo42XIcbQN3/2wgkMMNJvvvH057U2tdactfrba
         HXAHyfmTo3X+NLbMgXgs44VNVBThH6u6TISSBaoVHqTJtTomgJAs5K+ZV8Tou5BlMqR1
         fUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=C7jgHzHXrYhVO8nedhokWYsBV6IWdxzi5+EECVbrq4I=;
        b=TunwQUpCqINL3GHoTvBxDrMbNgkY33fLHdskg/YYfRnZ5MEOO5+hFw7h9yVizOEYjm
         XJk/ipbCYRM6ejp9tCbCsUWAADBv5EvQqn5Mw/uhbWqsIbPOU52dOivWJHd64eNxTYSP
         YA3ZCF3yxlU6D2QkZm3NuNW9Qo0BjQXGfbx2QudxUDeBbO96aWZbDOeyJU3GSQL1jhRL
         7+Cy6xl0KzVdRtpV6sA6AE4Fkkz4nAc+h5FFIZcvAyF669Gn8py8yGVSn/stum6Dkg6o
         2U9O4A6ycOvDp8aGfeo68fM5jzS8OLxFme3AOfA9VCeNod1W8Pxwi/ARlRXRW6NiM6on
         CHBw==
X-Gm-Message-State: ALoCoQnVATYkPpkx0RTuNKQYinUd5yAjnf8oVKz+hfftpjQBtzmeLWShs3qbCIn7WE6H+WHXHJAN
X-Received: by 10.55.19.197 with SMTP id 66mr52726425qkt.24.1433282963715;
 Tue, 02 Jun 2015 15:09:23 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 2 Jun 2015 15:09:23 -0700 (PDT)
In-Reply-To: <xmqq8uc123n5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270615>

On Tue, Jun 2, 2015 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Notes:
>>     name it to_free
>>
>>  transport.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/transport.c b/transport.c
>> index 651f0ac..b49fc60 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -496,15 +496,28 @@ static int set_git_option(struct git_transport_options *opts,
>>  static int connect_setup(struct transport *transport, int for_push, int verbose)
>>  {
>>       struct git_transport_data *data = transport->data;
>> +     const char *remote_program;
>> +     char *to_free = 0;
>
>         char *to_free = NULL;
>
>> +     remote_program = (for_push ? data->options.receivepack
>> +                                : data->options.uploadpack);
>> +
>> +     if (transport->smart_options->transport_version >= 2) {
>> +             to_free = xmalloc(strlen(remote_program) + 12);
>> +             sprintf(to_free, "%s-%d", remote_program,
>> +                     transport->smart_options->transport_version);
>> +             remote_program = to_free;
>> +     }
>
> Hmph, so everybody else thinks it is interacting with 'upload-pack',
> and this is the only function that knows it is actually talking with
> 'upload-pack-2'?

Yes.

>
> I am wondering why there isn't a separate helper function that
> munges data->options.{uploadpack,receivepack} fields based on
> the value of transport_version that is called _before_ this function
> is called.

That makes sense.

>
> Also, how does this interact with the name of the program the end
> user can specify via "fetch --upload-pack=<program name>" option?

You'd specify --upload-pack=foo-frotz and --transport-version=2
and it would look for foo-frotz-2 instead.

The problem IMHO is we have quite a few places where the
upload-pack binary path can be configured. Either as a command line
option or as a repository configuration.

And the way we're currently architecting the next protocol, the version
is encoded in the file name, which makes sense (an old binary will not
accept a new protocol), so what should happen when

* there is a repository configuration "upload-pack-custom" for upload-pack
   for historic reasons. When just switching to a new version, you would need
   to add a "upload-pack-custom-2" binary on the server side anyway

* additionally to the configured value you want to play around with the new
  protocol, so would you rather just say "--transport-version=2" or also need
  to have some sort of "--upload-pack=upload-pack-custom-another-path"
  involved? It's easy to forget the second option I believe.

* the user specifies
"--upload-pack=custom-upload-pack-which-talks-version1" and
 "--transport-version=2" together. This will fail, but at which stage do we
  want to fail?

All these questions lead me to think it's maybe better to make the rest of Git
unaware of the added "-${version}" string and pretend we would be talking to
upload-pack instead.
