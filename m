From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] git-am: add --message-id/--no-message-id options
Date: Tue, 25 Nov 2014 18:01:34 +0100
Message-ID: <5474B5EE.1030406@redhat.com>
References: <1416924056-29993-1-git-send-email-bonzini@gnu.org> <CAP8UFD0+Ef9JbbkZ+LBHcD6DVZiMGxFdrMnjLEViHHMERY5wuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Couder <christian.couder@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Nov 25 18:01:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtJUp-0003bO-SE
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 18:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbaKYRBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 12:01:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40243 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbaKYRBn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 12:01:43 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAPH1co6026817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Nov 2014 12:01:39 -0500
Received: from [10.36.112.79] (ovpn-112-79.ams2.redhat.com [10.36.112.79])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sAPH1YhW032254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 25 Nov 2014 12:01:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAP8UFD0+Ef9JbbkZ+LBHcD6DVZiMGxFdrMnjLEViHHMERY5wuw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260224>



On 25/11/2014 17:27, Christian Couder wrote:
>> > From: Paolo Bonzini <pbonzini@redhat.com>
>> >
>> > This series adds a --message-id option to git-mailinfo and git-am.
>> > git-am also gets an am.messageid configuration key to set the default,
>> > and a --no-message-id option to override the configuration key.
>> > (I'm not sure of the usefulness of a mailinfo.messageid option, so
>> > I left it out; this follows the example of -k instead of --scissors).
>> >
>> > This option can be useful in order to associate commit messages with
>> > mailing list discussions.
>> >
>> > If both --message-id and -s are specified, the Signed-off-by goes
>> > last.  This is coming out more or less naturally out of the git-am
>> > implementation, but is also tested in t4150-am.sh.
> Did you have a look at git interpret-trailers currently in master?

Hmm, now I have.

As far as I understand, all the git-am hooks are called on the commit
rather than the incoming email: all headers are lost by the time
git-mailinfo exits, including the Message-Id.  And you cannot call any
hook before git-mailinfo because git-mailinfo is where the
Content-Transfer-Encoding is processed.

How would you integrate git-interpret-trailers in git-mailinfo?

Paolo
