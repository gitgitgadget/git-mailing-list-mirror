From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v4 7/8] update-ref: support multiple simultaneous updates
Date: Thu, 05 Sep 2013 19:44:26 -0400
Message-ID: <5229175A.4070203@kitware.com>
References: <cover.1378142795.git.brad.king@kitware.com>	<cover.1378307529.git.brad.king@kitware.com>	<ad27a96b70198e837ac61995a1328960e10072bc.1378307529.git.brad.king@kitware.com>	<xmqqsixkmonq.fsf@gitster.dls.corp.google.com>	<52279107.2070205@kitware.com>	<xmqqd2ool1ks.fsf@gitster.dls.corp.google.com>	<5228EA62.7030606@kitware.com> <xmqqk3ivgdxz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 01:44:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHjE4-00042P-Sn
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 01:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758999Ab3IEXoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 19:44:32 -0400
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:53601 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758994Ab3IEXob (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Sep 2013 19:44:31 -0400
Received: from mail-qe0-f53.google.com ([209.85.128.53]) (using TLSv1) by na3sys009aob111.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUikXXjCCGYvr1OPTdxW5L/owycv3oPxN@postini.com; Thu, 05 Sep 2013 16:44:30 PDT
Received: by mail-qe0-f53.google.com with SMTP id 1so1147515qee.40
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 16:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nvEyi8aPjSbDYAOq8Lt5gnEBiyRUUdK5123Y7HoQOrc=;
        b=Cn9CHwgkkhq9MR76/OQ9gsSS0f6BmvyHQgA8waQogLyjCNJdksMulcOzb0dYZI15ZV
         zmzl9f/zk/XrdjtoRs0pj81zt7aLxNt+tQNS00T40oqG9eHMmYPbtXisCP5QU5RsC20V
         ow4iXA+NoJLxSCKN+7Yq4v5FMcAkHGYDzll7YaIpNqsaQWMEpX9zIQoqcP2ARp5C7mEN
         PFuxL+JVbOVWbD5H0p33DoYiaiG3bAREZDc4IgqRRit6WFNywpqjfQ2Q2chDiUStujTG
         jLwoYb9HEDPQk7owNZLLaSVi7Ru6KFDG91ZEfvrN6M843R5A80QWfjm9e51UqpHF0pBW
         nl4g==
X-Gm-Message-State: ALoCoQn9VLK9Jlpo8o6i64kfVojepfa3EHWbk9iueeu9SGHArEbrDcotSscFhNwNqos2oGvklwo2k002a4NNgxAF5KSeAb+5iB9eMWZV2o9XEpQhErXLyWz3Z524f/s/qUHqDhg4VKZm46cQVNCzq2k5cE3PvalLig==
X-Received: by 10.49.130.162 with SMTP id of2mr13035434qeb.37.1378424669813;
        Thu, 05 Sep 2013 16:44:29 -0700 (PDT)
X-Received: by 10.49.130.162 with SMTP id of2mr13035431qeb.37.1378424669746;
        Thu, 05 Sep 2013 16:44:29 -0700 (PDT)
Received: from [192.168.100.100] (cpe-74-67-63-118.nycap.res.rr.com. [74.67.63.118])
        by mx.google.com with ESMTPSA id p10sm653393qat.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Sep 2013 16:44:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <xmqqk3ivgdxz.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234005>

On 9/5/2013 5:23 PM, Junio C Hamano wrote:
> Brad King <brad.king@kitware.com> writes:
>> 	create SP <ref> NUL <newvalue> NUL
>> 	update SP <ref> NUL <newvalue> NUL [<oldvalue>] NUL
> 
> That SP in '-z' format looks strange.  Was there a reason why NUL
> was inappropriate?

The precedent I saw in the -z survey I posted is that NUL is used
to terminate fields that can contain arbitrary text but otherwise
SP or TAB is still used to terminate simple fields.  I recall no
cases that use NUL after fields that only contain simple values.

>> option::
>> 	Specify an option to take effect for following commands.
> 
> This last one is somewhat peculiar, especially because it says
> "following command*s*".
> 
> How would I request to update refs HEAD and next in an all-or-none
> fashion, while applying 'no-deref' only to HEAD but not next?

You're right.  It will be simpler for clients to generate each
sequence of options followed by a <ref> command without worrying
about options possibly generated for preceding <ref>s.  So:

option::
	Modify behavior of the next command naming a <ref>.
	The only valid option is `no-deref` to avoid dereferencing
	a symbolic ref.

> When I said "create or update" in the message you are responding to,
> I did not mean that we should have two separate commands.

The nice thing about "create" is that it implies oldvalue=zero, just
as "delete" implies newvalue=zero.  The symmetry feels clean.  Also,
in -z mode we need to treat an empty string <oldvalue> as missing
rather than zero.  The only way to specify create with the "update"
command is with literal 40 "0" as <oldvalue>.

> The regular command line does create-or-update; if it exists already,
> it is an update, and if it does not, it is a create.

The proposed update command can be used for create, update, delete,
or verify with proper arguments and use of 40 "0".  The other <ref>
commands are for convenience, shorter input, and statement of intent.

> 	create-or-update-no-deref <ref> <newvalue> [<oldvalue>]
>         delete-no-deref <ref> [<oldvalue>]
> 
> Also how would one set the reflog message for the proposed update?

This is why I proposed a separate option command.  It can be used
both for no-deref and for other options we want to add later e.g.

  option SP message SP <reason> LF

and with -z:

  option SP message SP <reason> NUL

For now I think it is sufficient for the -m <reason> command-line
option to set the same message for all updates.  The option command
leaves room to add a per-ref message later.

BTW, the reasons I propose message as an option rather than its own
command are:

* It is simpler to document the reach of the one option command
  (affects next <ref>) in one place rather than separately for
  each option-like command.

* It reduces the number of commands that do not take a <ref>.

-Brad
